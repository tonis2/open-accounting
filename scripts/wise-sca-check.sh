#!/usr/bin/env bash
# Checks a Wise API token + RSA private key pair by running the SCA handshake with
# curl and openssl, independently of the server. Prints only statuses and x-2fa headers.
#
# usage: wise-sca-check.sh <api-token> <private-key.pem> [profile-id] [balance-id]
#   without profile-id: lists the profiles the token can see
#   without balance-id: uses the first balance of the profile
set -euo pipefail
[ $# -ge 2 ] || { sed -n '2,7p' "$0"; exit 1; }
TOKEN=$1; KEY=$2; PROFILE=${3:-}; BAL=${4:-}
API=https://api.wise.com
auth=(-H "Authorization: Bearer $TOKEN")

[ -r "$KEY" ] || { echo "private key not readable: $KEY"; exit 1; }
openssl pkey -in "$KEY" -noout 2>/dev/null || { echo "not a valid PEM private key: $KEY"; exit 1; }

echo "== profiles visible to this token =="
curl -sf "${auth[@]}" "$API/v2/profiles" | python3 -c 'import sys,json
for p in json.load(sys.stdin): print(" ", p["id"], p["type"], p.get("businessName") or p.get("fullName") or "")'
[ -n "$PROFILE" ] || { echo "pass a profile id as 3rd argument"; exit 0; }

if [ -z "$BAL" ]; then
  echo "== balances of profile $PROFILE =="
  BALS=$(curl -sf "${auth[@]}" "$API/v4/profiles/$PROFILE/balances?types=STANDARD")
  echo "$BALS" | python3 -c 'import sys,json
for b in json.load(sys.stdin): print(" ", b["id"], b["currency"], b["amount"]["value"])'
  read -r BAL CUR < <(echo "$BALS" | python3 -c 'import sys,json; b=json.load(sys.stdin)[0]; print(b["id"], b["currency"])')
else
  CUR=$(curl -sf "${auth[@]}" "$API/v4/profiles/$PROFILE/balances?types=STANDARD" | python3 -c 'import sys,json
print(next(b["currency"] for b in json.load(sys.stdin) if str(b["id"])==sys.argv[1]))' "$BAL")
fi
echo "using balance $BAL ($CUR)"

END=$(date -u +%Y-%m-%dT00:00:00.000Z); START=$(date -u -d '30 days ago' +%Y-%m-%dT00:00:00.000Z)
URL="$API/v1/profiles/$PROFILE/balance-statements/$BAL/statement.json?currency=$CUR&intervalStart=$START&intervalEnd=$END&type=COMPACT"
show() { grep -i -E "^HTTP/|^x-2fa" | sed 's/^/  /' | sed -E 's/(x-2fa-approval: ).{8}.*/\1<ott…>/I'; }

echo "== 1st request =="
H=$(curl -s -D - -o /dev/null "${auth[@]}" "$URL")
echo "$H" | show
OTT=$(echo "$H" | awk 'tolower($1)=="x-2fa-approval:"{print $2}' | tr -d '\r')
[ -n "$OTT" ] || { echo "no SCA challenge received"; exit 1; }

echo "== signing one-time token (length ${#OTT}) =="
SIG=$(printf '%s' "$OTT" | openssl sha256 -sign "$KEY" | openssl base64 -A)
echo "  signature length ${#SIG}"

echo "== 2nd request with x-2fa-approval + X-Signature =="
R=$(curl -s -D - -o /dev/null "${auth[@]}" -H "x-2fa-approval: $OTT" -H "X-Signature: $SIG" "$URL")
echo "$R" | show
echo "$R" | grep -qi "x-2fa-approval-result: APPROVED" && echo "RESULT: key accepted — statements work" || echo "RESULT: Wise rejected the signature for profile $PROFILE"
