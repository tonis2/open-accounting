package auth

import (
	"errors"

	"golang.org/x/crypto/bcrypt"
)

var ErrWeakPassword = errors.New("password must be at least 8 characters")

func HashPassword(pw string) (string, error) {
	if len(pw) < 8 {
		return "", ErrWeakPassword
	}
	h, err := bcrypt.GenerateFromPassword([]byte(pw), 12)
	return string(h), err
}

func CheckPassword(hash, pw string) bool {
	return bcrypt.CompareHashAndPassword([]byte(hash), []byte(pw)) == nil
}
