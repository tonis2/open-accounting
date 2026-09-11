package crypto

import (
	"bytes"
	"testing"
)

func TestBoxRoundTrip(t *testing.T) {
	key := bytes.Repeat([]byte{7}, 32)
	box, err := NewBox(key)
	if err != nil {
		t.Fatal(err)
	}
	sealed, err := box.Seal([]byte(`{"api_token":"x"}`))
	if err != nil {
		t.Fatal(err)
	}
	plain, err := box.Open(sealed)
	if err != nil {
		t.Fatal(err)
	}
	if string(plain) != `{"api_token":"x"}` {
		t.Fatalf("got %q", plain)
	}
	sealed[len(sealed)-1] ^= 1
	if _, err := box.Open(sealed); err == nil {
		t.Fatal("tampered ciphertext must fail")
	}
}
