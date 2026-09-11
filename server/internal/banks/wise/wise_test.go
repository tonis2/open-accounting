package wise

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/pem"
	"errors"
	"open-accounting/server/internal/banks"
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
	var choice *banks.ChoiceRequired
	if _, err := pickProfile(profiles, "business", ""); !errors.As(err, &choice) || choice.Field != "profile_id" || len(choice.Options) != 2 || choice.Options[1].Label != "Internus" {
		t.Fatalf("expected a profile choice, got %v", err)
	}
	if !strings.Contains(choice.Error(), "1 (Geotrupes OÜ), 3 (Internus)") {
		t.Fatalf("error text should list the options, got %q", choice.Error())
	}
	pr, err := pickProfile(profiles, "business", "3")
	if err != nil || pr.ID != 3 {
		t.Fatalf("explicit id: got %+v, %v", pr, err)
	}
	pr, err = pickProfile(profiles, "personal", "")
	if err != nil || pr.ID != 2 {
		t.Fatalf("single match: got %+v, %v", pr, err)
	}
	if _, err := pickProfile(profiles, "business", "2"); !errors.As(err, &choice) {
		t.Fatalf("stale id with several candidates must ask again, got %v", err)
	}
	if pr, err := pickProfile(profiles, "personal", "999"); err != nil || pr.ID != 2 {
		t.Fatalf("stale id with one candidate must use it, got %+v %v", pr, err)
	}
	if _, err := pickProfile(profiles[:1], "personal", ""); err == nil {
		t.Fatal("missing type must error")
	}
}
