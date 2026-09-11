package storage

import (
	"crypto/rand"
	"errors"
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"strings"
)

const MaxAttachmentBytes = 10 * 1024 * 1024

var ErrUnsupportedType = errors.New("unsupported file type")

var extByMime = map[string]string{
	"application/pdf": ".pdf",
	"image/jpeg":      ".jpg",
	"image/png":       ".png",
	"image/webp":      ".webp",
}

// Store keeps uploaded files on local disk under a data directory.
type Store struct{ root string }

func New(root string) (*Store, error) {
	for _, d := range []string{"attachments", "invoices"} {
		if err := os.MkdirAll(filepath.Join(root, d), 0o755); err != nil {
			return nil, err
		}
	}
	return &Store{root: root}, nil
}

// DetectMime sniffs the content type and returns it with a matching extension.
func DetectMime(data []byte) (mime, ext string, err error) {
	n := min(512, len(data))
	mime = http.DetectContentType(data[:n])
	if i := strings.Index(mime, ";"); i > 0 {
		mime = mime[:i]
	}
	ext, ok := extByMime[mime]
	if !ok {
		return "", "", fmt.Errorf("%w: %s", ErrUnsupportedType, mime)
	}
	return mime, ext, nil
}

// SaveAttachment writes the bytes under attachments/<company>/<random><ext> and returns the relative path.
func (s *Store) SaveAttachment(companyID int64, ext string, data []byte) (string, error) {
	dir := filepath.Join("attachments", fmt.Sprint(companyID))
	if err := os.MkdirAll(filepath.Join(s.root, dir), 0o755); err != nil {
		return "", err
	}
	b := make([]byte, 16)
	_, _ = rand.Read(b)
	rel := filepath.Join(dir, fmt.Sprintf("%x%s", b, ext))
	return rel, os.WriteFile(filepath.Join(s.root, rel), data, 0o644)
}

func (s *Store) Read(rel string) ([]byte, error) {
	return os.ReadFile(filepath.Join(s.root, filepath.Clean(rel)))
}

func (s *Store) Delete(rel string) error {
	err := os.Remove(filepath.Join(s.root, filepath.Clean(rel)))
	if errors.Is(err, os.ErrNotExist) {
		return nil
	}
	return err
}

// InvoicePDFPath is where a rendered invoice is cached.
func (s *Store) InvoicePDFPath(companyID int64, number string) string {
	safe := strings.Map(func(r rune) rune {
		if r == '/' || r == '\\' || r == ' ' {
			return '_'
		}
		return r
	}, number)
	return filepath.Join("invoices", fmt.Sprint(companyID), safe+".pdf")
}

func (s *Store) Write(rel string, data []byte) error {
	full := filepath.Join(s.root, rel)
	if err := os.MkdirAll(filepath.Dir(full), 0o755); err != nil {
		return err
	}
	return os.WriteFile(full, data, 0o644)
}
