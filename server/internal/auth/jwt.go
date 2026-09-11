package auth

import (
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

const issuer = "open-accounting"

// Tokens signs and parses HS256 session tokens.
type Tokens struct {
	secret []byte
	ttl    time.Duration
}

func NewTokens(secret string) *Tokens {
	return &Tokens{secret: []byte(secret), ttl: 12 * time.Hour}
}

func (t *Tokens) Create(userID int64, email string) (string, error) {
	claims := jwt.MapClaims{
		"id":    userID,
		"email": email,
		"iss":   issuer,
		"iat":   time.Now().Unix(),
		"exp":   time.Now().Add(t.ttl).Unix(),
	}
	return jwt.NewWithClaims(jwt.SigningMethodHS256, claims).SignedString(t.secret)
}

// Parse validates the token and returns the user id.
func (t *Tokens) Parse(token string) (int64, error) {
	parsed, err := jwt.Parse(token, func(tok *jwt.Token) (any, error) {
		if _, ok := tok.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method %v", tok.Header["alg"])
		}
		return t.secret, nil
	}, jwt.WithIssuer(issuer), jwt.WithExpirationRequired())
	if err != nil {
		return 0, err
	}
	claims, ok := parsed.Claims.(jwt.MapClaims)
	if !ok || !parsed.Valid {
		return 0, fmt.Errorf("invalid token")
	}
	id, ok := claims["id"].(float64)
	if !ok {
		return 0, fmt.Errorf("invalid token payload")
	}
	return int64(id), nil
}
