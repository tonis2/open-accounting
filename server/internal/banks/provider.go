package banks

import (
	"context"
	"encoding/json"
	"errors"
	"time"
)

// ErrConsentExpired signals that the user must re-authorise the connection at the bank.
var ErrConsentExpired = errors.New("bank consent expired")

// ErrStatementsUnavailable marks a provider that can report balances but is not allowed to
// deliver transactions for this account; the connection stays active and rows come from uploads.
var ErrStatementsUnavailable = errors.New("statements unavailable")

// Config is the user-entered provider configuration (stored encrypted).
type Config map[string]string

type FieldKind string

const (
	FieldText      FieldKind = "text"
	FieldSecret    FieldKind = "secret"
	FieldMultiline FieldKind = "multiline"
	FieldSelect    FieldKind = "select"
	FieldBool      FieldKind = "bool"
)

// ConfigField describes one input the dashboard renders when connecting a bank.
type ConfigField struct {
	Key      string
	Label    string
	Hint     string
	Kind     FieldKind
	Options  []string
	Required bool
	Default  string
}

type Account struct {
	ExternalID   string
	Name         string
	IBAN         string
	Currency     string
	BalanceCents int64
	BalanceAt    time.Time
}

type Transaction struct {
	ExternalID       string
	BookedAt         time.Time
	ValueDate        time.Time
	AmountCents      int64 // signed: positive = money in
	Currency         string
	Description      string
	CounterpartyName string
	CounterpartyIBAN string
	Reference        string
	Raw              json.RawMessage
}

type Institution struct {
	ID                   string
	Name                 string
	BIC                  string
	LogoURL              string
	TransactionTotalDays int
}

// ConnectResult is returned by Connect/CompleteConnect. An empty RedirectURL means the
// connection is usable immediately.
type ConnectResult struct {
	RedirectURL      string
	State            json.RawMessage
	ConsentExpiresAt *time.Time
}

// Provider is implemented once per bank/aggregator. State is provider-private JSON that
// persists between calls (profile ids, requisition ids, cached tokens...).
type Provider interface {
	ID() string
	Name() string
	Description() string
	ConfigFields() []ConfigField
	NeedsRedirect() bool
	Connect(ctx context.Context, cfg Config, callbackURL string) (ConnectResult, error)
	CompleteConnect(ctx context.Context, cfg Config, state json.RawMessage, params map[string]string) (ConnectResult, error)
	ListAccounts(ctx context.Context, cfg Config, state json.RawMessage) ([]Account, error)
	FetchTransactions(ctx context.Context, cfg Config, state json.RawMessage, acct Account, from, to time.Time) ([]Transaction, error)
}

// InstitutionLister is implemented by aggregators where the user picks a bank first.
type InstitutionLister interface {
	ListInstitutions(ctx context.Context, cfg Config, country string) ([]Institution, error)
}

// BalanceFromTransactions marks providers whose accounts have no API balance: the runner keeps
// balance_cents = opening balance + sum of imported transactions.
type BalanceFromTransactions interface {
	BalanceFromTransactions() bool
}

// SyncThrottler lets a provider enforce a minimum interval between syncs (API rate limits).
type SyncThrottler interface {
	MinSyncInterval() time.Duration
}

// Registry holds the enabled providers in registration order.
type Registry struct {
	order []string
	byID  map[string]Provider
}

func NewRegistry() *Registry { return &Registry{byID: map[string]Provider{}} }

func (r *Registry) Register(p Provider) {
	if _, dup := r.byID[p.ID()]; dup {
		return
	}
	r.order = append(r.order, p.ID())
	r.byID[p.ID()] = p
}

func (r *Registry) Get(id string) (Provider, bool) {
	p, ok := r.byID[id]
	return p, ok
}

func (r *Registry) All() []Provider {
	out := make([]Provider, 0, len(r.order))
	for _, id := range r.order {
		out = append(out, r.byID[id])
	}
	return out
}

// Validate checks required fields and select options.
func Validate(p Provider, cfg Config) error {
	for _, f := range p.ConfigFields() {
		v := cfg[f.Key]
		if f.Required && v == "" {
			return errors.New(f.Label + " is required")
		}
		if f.Kind == FieldSelect && v != "" && len(f.Options) > 0 {
			ok := false
			for _, o := range f.Options {
				if o == v {
					ok = true
				}
			}
			if !ok {
				return errors.New(f.Label + ": invalid option")
			}
		}
	}
	return nil
}
