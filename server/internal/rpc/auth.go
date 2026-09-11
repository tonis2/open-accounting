package rpc

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"strings"
	"time"

	"github.com/go-webauthn/webauthn/protocol"
	"github.com/go-webauthn/webauthn/webauthn"
	"github.com/jackc/pgx/v5"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"open-accounting/server/internal/auth"
	"open-accounting/server/pb"
)

type userRow struct {
	ID           int64
	Email        string
	Name         string
	PasswordHash *string
	Enabled      bool
	CreatedAt    time.Time
}

func (u userRow) proto() *pb.User {
	return &pb.User{Id: uint64(u.ID), Email: u.Email, Name: u.Name, HasPassword: u.PasswordHash != nil, CreatedAt: tsv(u.CreatedAt)}
}

func (s *Server) userByEmail(ctx context.Context, email string) (userRow, error) {
	var u userRow
	err := s.DB.QueryRow(ctx, "SELECT id, email, name, password_hash, enabled, created_at FROM users WHERE email=$1", strings.TrimSpace(email)).
		Scan(&u.ID, &u.Email, &u.Name, &u.PasswordHash, &u.Enabled, &u.CreatedAt)
	return u, err
}

func (s *Server) userByID(ctx context.Context, id int64) (userRow, error) {
	var u userRow
	err := s.DB.QueryRow(ctx, "SELECT id, email, name, password_hash, enabled, created_at FROM users WHERE id=$1", id).
		Scan(&u.ID, &u.Email, &u.Name, &u.PasswordHash, &u.Enabled, &u.CreatedAt)
	return u, err
}

func (s *Server) authResponse(u userRow) (*pb.AuthResponse, error) {
	token, err := s.Tokens.Create(u.ID, u.Email)
	if err != nil {
		return nil, internalErr(err)
	}
	return &pb.AuthResponse{Token: token, User: u.proto()}, nil
}

func validEmail(e string) bool {
	e = strings.TrimSpace(e)
	at := strings.Index(e, "@")
	return at > 0 && strings.Contains(e[at:], ".") && len(e) <= 200
}

// ---- password auth ----

func (s *Server) Register(ctx context.Context, req *pb.RegisterRequest) (*pb.AuthResponse, error) {
	if !s.Cfg.AllowRegistration {
		return nil, status.Error(codes.PermissionDenied, "registration is disabled")
	}
	if !validEmail(req.Email) {
		return nil, invalid("valid email is required")
	}
	if strings.TrimSpace(req.Name) == "" {
		return nil, invalid("name is required")
	}
	hash, err := auth.HashPassword(req.Password)
	if err != nil {
		return nil, invalid(err.Error())
	}
	var u userRow
	err = s.DB.QueryRow(ctx, `INSERT INTO users (email, name, password_hash) VALUES ($1, $2, $3)
		RETURNING id, email, name, password_hash, enabled, created_at`, strings.TrimSpace(strings.ToLower(req.Email)), strings.TrimSpace(req.Name), hash).
		Scan(&u.ID, &u.Email, &u.Name, &u.PasswordHash, &u.Enabled, &u.CreatedAt)
	if err != nil {
		if e := dbErr(err); status.Code(e) == codes.AlreadyExists {
			return nil, status.Error(codes.AlreadyExists, "an account with this email already exists")
		}
		return nil, dbErr(err)
	}
	slog.Info("[AUTH] registered", "user", u.ID)
	return s.authResponse(u)
}

func (s *Server) Login(ctx context.Context, req *pb.LoginRequest) (*pb.AuthResponse, error) {
	key := strings.ToLower(strings.TrimSpace(req.Email))
	if !s.Limiter.Allow("pw:" + key) {
		return nil, status.Error(codes.ResourceExhausted, "too many attempts, try again later")
	}
	u, err := s.userByEmail(ctx, key)
	if errors.Is(err, pgx.ErrNoRows) || (err == nil && (u.PasswordHash == nil || !auth.CheckPassword(*u.PasswordHash, req.Password))) {
		return nil, status.Error(codes.Unauthenticated, "invalid email or password")
	}
	if err != nil {
		return nil, internalErr(err)
	}
	if !u.Enabled {
		return nil, status.Error(codes.PermissionDenied, "account disabled")
	}
	s.Limiter.Reset("pw:" + key)
	return s.authResponse(u)
}

func (s *Server) Me(ctx context.Context, _ *pb.Empty) (*pb.User, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	u, err := s.userByID(ctx, uid)
	if err != nil {
		return nil, dbErr(err)
	}
	return u.proto(), nil
}

func (s *Server) ChangePassword(ctx context.Context, req *pb.ChangePasswordRequest) (*pb.Empty, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	u, err := s.userByID(ctx, uid)
	if err != nil {
		return nil, dbErr(err)
	}
	if u.PasswordHash != nil && !auth.CheckPassword(*u.PasswordHash, req.CurrentPassword) {
		return nil, status.Error(codes.PermissionDenied, "current password is incorrect")
	}
	hash, err := auth.HashPassword(req.NewPassword)
	if err != nil {
		return nil, invalid(err.Error())
	}
	if _, err := s.DB.Exec(ctx, "UPDATE users SET password_hash=$1 WHERE id=$2", hash, uid); err != nil {
		return nil, internalErr(err)
	}
	return &pb.Empty{}, nil
}

// ---- recovery ----

func (s *Server) RequestRecovery(ctx context.Context, req *pb.RequestRecoveryRequest) (*pb.Empty, error) {
	if !s.Mail.Enabled() {
		return nil, status.Error(codes.FailedPrecondition, "email is not configured on this server")
	}
	key := strings.ToLower(strings.TrimSpace(req.Email))
	if !s.Limiter.Allow("rec:" + key) {
		return nil, status.Error(codes.ResourceExhausted, "too many attempts, try again later")
	}
	u, err := s.userByEmail(ctx, key)
	if err != nil {
		// Always succeed so emails cannot be enumerated.
		return &pb.Empty{}, nil
	}
	token := auth.RandomToken(32)
	_, err = s.DB.Exec(ctx, "INSERT INTO recovery_tokens (user_id, token, expires_at) VALUES ($1, $2, now() + interval '30 minutes')", u.ID, token)
	if err != nil {
		return nil, internalErr(err)
	}
	link := fmt.Sprintf("%s/recover?token=%s", s.Cfg.PublicURL, token)
	body := fmt.Sprintf("Hello %s,\n\nUse the link below to set a new password. It is valid for 30 minutes.\n\n%s\n\nIf you did not request this, you can ignore this email.", u.Name, link)
	go func() {
		if err := s.Mail.Send(context.Background(), u.Email, "Reset your Open Accounting password", body); err != nil {
			slog.Error("[MAIL] recovery email failed", "err", err)
		}
	}()
	return &pb.Empty{}, nil
}

func (s *Server) ValidateRecoveryToken(ctx context.Context, req *pb.RecoveryTokenRequest) (*pb.RecoveryTokenResponse, error) {
	var email string
	err := s.DB.QueryRow(ctx, `SELECT u.email FROM recovery_tokens t JOIN users u ON u.id=t.user_id
		WHERE t.token=$1 AND t.used=false AND t.expires_at > now()`, req.Token).Scan(&email)
	if errors.Is(err, pgx.ErrNoRows) {
		return &pb.RecoveryTokenResponse{Valid: false}, nil
	}
	if err != nil {
		return nil, internalErr(err)
	}
	return &pb.RecoveryTokenResponse{Valid: true, Email: email}, nil
}

func (s *Server) RecoverAccount(ctx context.Context, req *pb.RecoverAccountRequest) (*pb.AuthResponse, error) {
	hash, err := auth.HashPassword(req.NewPassword)
	if err != nil {
		return nil, invalid(err.Error())
	}
	var uid int64
	err = s.DB.QueryRow(ctx, `UPDATE recovery_tokens SET used=true WHERE token=$1 AND used=false AND expires_at > now() RETURNING user_id`, req.Token).Scan(&uid)
	if errors.Is(err, pgx.ErrNoRows) {
		return nil, status.Error(codes.NotFound, "invalid or expired link")
	}
	if err != nil {
		return nil, internalErr(err)
	}
	if _, err := s.DB.Exec(ctx, "UPDATE users SET password_hash=$1 WHERE id=$2", hash, uid); err != nil {
		return nil, internalErr(err)
	}
	u, err := s.userByID(ctx, uid)
	if err != nil {
		return nil, dbErr(err)
	}
	return s.authResponse(u)
}

// ---- passkeys ----

func (s *Server) loadWebAuthnUser(ctx context.Context, u userRow) (*auth.WebAuthnUser, error) {
	rows, err := s.DB.Query(ctx, "SELECT credential FROM passkeys WHERE user_id=$1", u.ID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	wu := &auth.WebAuthnUser{ID: u.ID, Email: u.Email, Name: u.Name}
	for rows.Next() {
		var raw []byte
		if err := rows.Scan(&raw); err != nil {
			return nil, err
		}
		var c webauthn.Credential
		if err := json.Unmarshal(raw, &c); err != nil {
			return nil, err
		}
		wu.Credentials = append(wu.Credentials, c)
	}
	return wu, rows.Err()
}

func (s *Server) BeginPasskeyRegistration(ctx context.Context, _ *pb.Empty) (*pb.PasskeyOptionsResponse, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	u, err := s.userByID(ctx, uid)
	if err != nil {
		return nil, dbErr(err)
	}
	wu, err := s.loadWebAuthnUser(ctx, u)
	if err != nil {
		return nil, internalErr(err)
	}
	exclusions := make([]protocol.CredentialDescriptor, 0, len(wu.Credentials))
	for _, c := range wu.Credentials {
		exclusions = append(exclusions, c.Descriptor())
	}
	creation, session, err := s.WebAuthn.BeginRegistration(wu,
		webauthn.WithExclusions(exclusions),
		webauthn.WithAuthenticatorSelection(protocol.AuthenticatorSelection{
			ResidentKey:      protocol.ResidentKeyRequirementPreferred,
			UserVerification: protocol.VerificationPreferred,
		}),
	)
	if err != nil {
		return nil, internalErr(err)
	}
	opts, _ := json.Marshal(creation)
	return &pb.PasskeyOptionsResponse{SessionId: s.Sessions.Put(session, uid), OptionsJson: string(opts)}, nil
}

func (s *Server) FinishPasskeyRegistration(ctx context.Context, req *pb.FinishPasskeyRequest) (*pb.Passkey, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	session, sessUser, err := s.Sessions.Take(req.SessionId)
	if err != nil || sessUser != uid {
		return nil, status.Error(codes.FailedPrecondition, "passkey session expired, please try again")
	}
	u, err := s.userByID(ctx, uid)
	if err != nil {
		return nil, dbErr(err)
	}
	wu, err := s.loadWebAuthnUser(ctx, u)
	if err != nil {
		return nil, internalErr(err)
	}
	parsed, err := protocol.ParseCredentialCreationResponseBody(strings.NewReader(req.CredentialJson))
	if err != nil {
		return nil, invalid("invalid passkey response: " + err.Error())
	}
	cred, err := s.WebAuthn.CreateCredential(wu, *session, parsed)
	if err != nil {
		return nil, status.Error(codes.InvalidArgument, "passkey verification failed: "+err.Error())
	}
	raw, _ := json.Marshal(cred)
	name := strings.TrimSpace(req.Name)
	if name == "" {
		name = "Passkey"
	}
	var pk pb.Passkey
	var created time.Time
	err = s.DB.QueryRow(ctx, "INSERT INTO passkeys (user_id, credential_id, credential, name) VALUES ($1,$2,$3,$4) RETURNING id, created_at",
		uid, cred.ID, raw, name).Scan(&pk.Id, &created)
	if err != nil {
		return nil, dbErr(err)
	}
	pk.Name = name
	pk.CreatedAt = tsv(created)
	return &pk, nil
}

func (s *Server) BeginPasskeyLogin(ctx context.Context, req *pb.BeginPasskeyLoginRequest) (*pb.PasskeyOptionsResponse, error) {
	key := strings.ToLower(strings.TrimSpace(req.Email))
	if !s.Limiter.Allow("pk:" + key) {
		return nil, status.Error(codes.ResourceExhausted, "too many attempts, try again later")
	}
	// With a known user we can restrict allowCredentials; otherwise fall back to a discoverable login.
	if key != "" {
		if u, err := s.userByEmail(ctx, key); err == nil && u.Enabled {
			if wu, err := s.loadWebAuthnUser(ctx, u); err == nil && len(wu.Credentials) > 0 {
				assertion, session, err := s.WebAuthn.BeginLogin(wu)
				if err != nil {
					return nil, internalErr(err)
				}
				opts, _ := json.Marshal(assertion)
				return &pb.PasskeyOptionsResponse{SessionId: s.Sessions.Put(session, u.ID), OptionsJson: string(opts)}, nil
			}
		}
	}
	assertion, session, err := s.WebAuthn.BeginDiscoverableLogin()
	if err != nil {
		return nil, internalErr(err)
	}
	opts, _ := json.Marshal(assertion)
	return &pb.PasskeyOptionsResponse{SessionId: s.Sessions.Put(session, 0), OptionsJson: string(opts)}, nil
}

func (s *Server) FinishPasskeyLogin(ctx context.Context, req *pb.FinishPasskeyRequest) (*pb.AuthResponse, error) {
	session, sessUser, err := s.Sessions.Take(req.SessionId)
	if err != nil {
		return nil, status.Error(codes.FailedPrecondition, "passkey session expired, please try again")
	}
	parsed, err := protocol.ParseCredentialRequestResponseBody(strings.NewReader(req.CredentialJson))
	if err != nil {
		return nil, invalid("invalid passkey response: " + err.Error())
	}

	var user userRow
	var cred *webauthn.Credential
	if sessUser != 0 {
		user, err = s.userByID(ctx, sessUser)
		if err != nil {
			return nil, dbErr(err)
		}
		wu, err := s.loadWebAuthnUser(ctx, user)
		if err != nil {
			return nil, internalErr(err)
		}
		cred, err = s.WebAuthn.ValidateLogin(wu, *session, parsed)
		if err != nil {
			return nil, status.Error(codes.Unauthenticated, "passkey verification failed")
		}
	} else {
		handler := func(_, userHandle []byte) (webauthn.User, error) {
			id, ok := auth.UserIDFromHandle(userHandle)
			if !ok {
				return nil, errors.New("unknown user handle")
			}
			u, err := s.userByID(ctx, id)
			if err != nil {
				return nil, err
			}
			user = u
			return s.loadWebAuthnUser(ctx, u)
		}
		cred, err = s.WebAuthn.ValidateDiscoverableLogin(handler, *session, parsed)
		if err != nil {
			return nil, status.Error(codes.Unauthenticated, "passkey verification failed")
		}
	}
	if !user.Enabled {
		return nil, status.Error(codes.PermissionDenied, "account disabled")
	}
	raw, _ := json.Marshal(cred)
	_, _ = s.DB.Exec(ctx, "UPDATE passkeys SET credential=$1, last_used_at=now() WHERE credential_id=$2", raw, cred.ID)
	s.Limiter.Reset("pk:" + strings.ToLower(user.Email))
	return s.authResponse(user)
}

func (s *Server) ListPasskeys(ctx context.Context, _ *pb.Empty) (*pb.ListPasskeysResponse, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	rows, err := s.DB.Query(ctx, "SELECT id, name, created_at, last_used_at FROM passkeys WHERE user_id=$1 ORDER BY created_at", uid)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	out := &pb.ListPasskeysResponse{}
	for rows.Next() {
		var pk pb.Passkey
		var created time.Time
		var used *time.Time
		if err := rows.Scan(&pk.Id, &pk.Name, &created, &used); err != nil {
			return nil, internalErr(err)
		}
		pk.CreatedAt = tsv(created)
		pk.LastUsedAt = ts(used)
		out.Items = append(out.Items, &pk)
	}
	return out, nil
}

func (s *Server) DeletePasskey(ctx context.Context, req *pb.IdRequest) (*pb.Empty, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	u, err := s.userByID(ctx, uid)
	if err != nil {
		return nil, dbErr(err)
	}
	var count int
	_ = s.DB.QueryRow(ctx, "SELECT count(*) FROM passkeys WHERE user_id=$1", uid).Scan(&count)
	if u.PasswordHash == nil && count <= 1 {
		return nil, status.Error(codes.FailedPrecondition, "set a password before removing your last passkey")
	}
	tag, err := s.DB.Exec(ctx, "DELETE FROM passkeys WHERE id=$1 AND user_id=$2", req.Id, uid)
	if err != nil {
		return nil, internalErr(err)
	}
	if tag.RowsAffected() == 0 {
		return nil, status.Error(codes.NotFound, "passkey not found")
	}
	return &pb.Empty{}, nil
}
