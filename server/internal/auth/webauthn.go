package auth

import (
	"crypto/rand"
	"encoding/base64"
	"encoding/binary"
	"errors"
	"sync"
	"time"

	"github.com/go-webauthn/webauthn/webauthn"
)

var ErrSessionExpired = errors.New("passkey session expired")

// WebAuthnUser adapts a users row plus its passkeys to the library's User interface.
type WebAuthnUser struct {
	ID          int64
	Email       string
	Name        string
	Credentials []webauthn.Credential
}

func (u *WebAuthnUser) WebAuthnID() []byte {
	b := make([]byte, 8)
	binary.BigEndian.PutUint64(b, uint64(u.ID))
	return b
}
func (u *WebAuthnUser) WebAuthnName() string                       { return u.Email }
func (u *WebAuthnUser) WebAuthnDisplayName() string                { return u.Name }
func (u *WebAuthnUser) WebAuthnCredentials() []webauthn.Credential { return u.Credentials }

// UserIDFromHandle decodes the id written by WebAuthnID.
func UserIDFromHandle(handle []byte) (int64, bool) {
	if len(handle) != 8 {
		return 0, false
	}
	return int64(binary.BigEndian.Uint64(handle)), true
}

// Sessions keeps in-flight WebAuthn ceremonies in memory (single instance server).
type Sessions struct {
	mu   sync.Mutex
	ttl  time.Duration
	data map[string]sessionEntry
}

type sessionEntry struct {
	data    webauthn.SessionData
	userID  int64
	expires time.Time
}

func NewSessions() *Sessions {
	return &Sessions{ttl: 5 * time.Minute, data: map[string]sessionEntry{}}
}

func (s *Sessions) Put(data *webauthn.SessionData, userID int64) string {
	b := make([]byte, 24)
	_, _ = rand.Read(b)
	id := base64.RawURLEncoding.EncodeToString(b)
	s.mu.Lock()
	s.data[id] = sessionEntry{data: *data, userID: userID, expires: time.Now().Add(s.ttl)}
	for k, e := range s.data {
		if time.Now().After(e.expires) {
			delete(s.data, k)
		}
	}
	s.mu.Unlock()
	return id
}

// Take removes and returns the session; each ceremony can only be finished once.
func (s *Sessions) Take(id string) (*webauthn.SessionData, int64, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	e, ok := s.data[id]
	delete(s.data, id)
	if !ok || time.Now().After(e.expires) {
		return nil, 0, ErrSessionExpired
	}
	return &e.data, e.userID, nil
}

// RandomToken returns a URL-safe random string for recovery links and bank references.
func RandomToken(n int) string {
	b := make([]byte, n)
	_, _ = rand.Read(b)
	return base64.RawURLEncoding.EncodeToString(b)
}
