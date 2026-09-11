package mail

import (
	"bytes"
	"context"
	"errors"
	"fmt"

	gomail "github.com/wneessen/go-mail"
)

var ErrDisabled = errors.New("email is not configured (SMTP_HOST is empty)")

// Sender delivers transactional email over SMTP. A nil Sender means mail is disabled.
type Sender struct {
	host string
	port int
	user string
	pass string
	from string
}

func New(host string, port int, user, pass, from string) *Sender {
	if host == "" {
		return nil
	}
	return &Sender{host: host, port: port, user: user, pass: pass, from: from}
}

type Attachment struct {
	Name string
	Data []byte
}

func (s *Sender) Enabled() bool { return s != nil }

// Send delivers a plain-text message with optional attachments.
func (s *Sender) Send(ctx context.Context, to, subject, body string, attachments ...Attachment) error {
	if s == nil {
		return ErrDisabled
	}
	msg := gomail.NewMsg()
	if err := msg.From(s.from); err != nil {
		return fmt.Errorf("from: %w", err)
	}
	if err := msg.To(to); err != nil {
		return fmt.Errorf("to: %w", err)
	}
	msg.Subject(subject)
	msg.SetBodyString(gomail.TypeTextPlain, body)
	for _, a := range attachments {
		msg.AttachReader(a.Name, bytes.NewReader(a.Data))
	}

	opts := []gomail.Option{gomail.WithPort(s.port), gomail.WithTLSPolicy(gomail.TLSOpportunistic)}
	if s.user != "" {
		opts = append(opts, gomail.WithSMTPAuth(gomail.SMTPAuthPlain), gomail.WithUsername(s.user), gomail.WithPassword(s.pass))
	}
	if s.port == 465 {
		opts = append(opts, gomail.WithSSLPort(false))
	}
	client, err := gomail.NewClient(s.host, opts...)
	if err != nil {
		return err
	}
	return client.DialAndSendWithContext(ctx, msg)
}
