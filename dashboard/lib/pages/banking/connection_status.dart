import 'package:flutter/material.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/format.dart';
import '../../state.dart';

BadgeTone connectionTone(ConnectionStatus s, Timestamp consentExpires) {
  switch (s) {
    case ConnectionStatus.CONNECTION_STATUS_ACTIVE:
      if (consentExpires.hasSeconds() && consentExpires.toDateTime().difference(DateTime.now()).inDays < 7) return BadgeTone.warning;
      return BadgeTone.success;
    case ConnectionStatus.CONNECTION_STATUS_PENDING:
      return BadgeTone.info;
    case ConnectionStatus.CONNECTION_STATUS_EXPIRED:
      return BadgeTone.danger;
    default:
      return BadgeTone.danger;
  }
}

String connectionLabel(AppLocalizations l, ConnectionStatus s, Timestamp consentExpires) {
  switch (s) {
    case ConnectionStatus.CONNECTION_STATUS_ACTIVE:
      if (consentExpires.hasSeconds() && consentExpires.toDateTime().difference(DateTime.now()).inDays < 7) return l.feedExpiresSoon;
      return l.feedActive;
    case ConnectionStatus.CONNECTION_STATUS_PENDING:
      return l.feedPending;
    case ConnectionStatus.CONNECTION_STATUS_EXPIRED:
      return l.feedExpired;
    default:
      return l.feedError;
  }
}

/// Two-line feed status cell: coloured label plus expiry / last import.
Widget connectionStatusColumn(
  BuildContext context,
  ConnectionStatus s,
  Timestamp consentExpires,
  Timestamp lastSync, {
  String message = '',
  bool statementsOnly = false,
}) {
  final l = AppLocalizations.of(context)!;
  final theme = Theme.of(context);
  final tone = connectionTone(s, consentExpires);
  final color = switch (tone) {
    BadgeTone.success => const Color(0xFF3A8F3A),
    BadgeTone.warning => const Color(0xFFE0851A),
    BadgeTone.danger => theme.colorScheme.error,
    BadgeTone.info => const Color(0xFF2F8FE5),
    BadgeTone.neutral => theme.colorScheme.onSurfaceVariant,
  };
  final detail = consentExpires.hasSeconds() && s == ConnectionStatus.CONNECTION_STATUS_ACTIVE
      ? l.feedExpiresIn(_relative(l, consentExpires.toDateTime()))
      : (lastSync.hasSeconds() ? '${l.feedLastImport} ${formatDateTime(lastSync)}' : l.feedNeverSynced);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        connectionLabel(l, s, consentExpires),
        style: theme.textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
      Text(detail, style: theme.textTheme.bodySmall),
      if (message.isNotEmpty)
        Text(
          message,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(color: tone == BadgeTone.danger ? theme.colorScheme.error : null),
        )
      else if (statementsOnly)
        Text(l.feedStatementsOnly, style: theme.textTheme.bodySmall),
    ],
  );
}

String _relative(AppLocalizations l, DateTime when) {
  final diff = when.difference(DateTime.now());
  if (diff.isNegative) return formatDate(when);
  if (diff.inHours < 48) return l.inAboutHours(diff.inHours);
  return l.inDays(diff.inDays);
}

/// Opens the bank's authorisation page in the same tab so the callback lands back in the app.
Future<void> openExternal(String url) async {
  await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
}

final Map<int, String> _loggedIssues = {};

/// Mirrors connection problems reported by the server into the browser console,
/// once per distinct message so reloads stay quiet.
void logConnectionIssues(List<BankConnection> connections) {
  for (final c in connections) {
    final key = c.id.toInt();
    final ok = c.status == ConnectionStatus.CONNECTION_STATUS_ACTIVE || c.status == ConnectionStatus.CONNECTION_STATUS_PENDING;
    if (ok || c.statusMessage.isEmpty) {
      _loggedIssues.remove(key);
      continue;
    }
    if (_loggedIssues[key] == c.statusMessage) continue;
    _loggedIssues[key] = c.statusMessage;
    AppLogger.warning('[BANK] ${c.name} (${c.provider}): ${c.statusMessage}');
  }
}
