package wise

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/pem"
	"strings"
	"testing"
)

func TestSignOTT(t *testing.T) {
	key, _ := rsa.GenerateKey(rand.Reader, 2048)
	pemKey := pem.EncodeToMemory(&pem.Block{Type: "RSA PRIVATE KEY", Bytes: x509.MarshalPKCS1PrivateKey(key)})
	sig, err := signOTT(string(pemKey), "abc")
	if err != nil || sig == "" {
		t.Fatalf("sig=%q err=%v", sig, err)
	}
	if _, err := signOTT("", "abc"); err == nil {
		t.Fatal("expected error without key")
	}
}

func TestNumberToCents(t *testing.T) {
	if c, _ := numberToCents("-12.5"); c != -1250 {
		t.Fatalf("got %d", c)
	}
}

func TestPickProfile(t *testing.T) {
	profiles := []profile{
		{ID: 1, Type: "BUSINESS", BusinessName: "Geotrupes OÜ"},
		{ID: 2, Type: "PERSONAL", FullName: "Tonis"},
		{ID: 3, Type: "BUSINESS", BusinessName: "Internus"},
	}
	if _, err := pickProfile(profiles, "business", ""); err == nil || !strings.Contains(err.Error(), "1 (Geotrupes OÜ), 3 (Internus)") {
		t.Fatalf("expected ambiguity error listing profiles, got %v", err)
	}
	pr, err := pickProfile(profiles, "business", "3")
	if err != nil || pr.ID != 3 {
		t.Fatalf("explicit id: got %+v, %v", pr, err)
	}
	pr, err = pickProfile(profiles, "personal", "")
	if err != nil || pr.ID != 2 {
		t.Fatalf("single match: got %+v, %v", pr, err)
	}
	if _, err := pickProfile(profiles, "business", "2"); err == nil {
		t.Fatal("id of another type must be rejected")
	}
	if _, err := pickProfile(profiles[:1], "personal", ""); err == nil {
		t.Fatal("missing type must error")
	}
}
