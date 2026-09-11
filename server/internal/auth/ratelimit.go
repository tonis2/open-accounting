package auth

import (
	"sync"
	"time"
)

// Limiter is a small fixed-window counter keyed by string (e.g. email) for login attempts.
type Limiter struct {
	mu     sync.Mutex
	max    int
	window time.Duration
	hits   map[string]*bucket
}

type bucket struct {
	count int
	reset time.Time
}

func NewLimiter(max int, window time.Duration) *Limiter {
	return &Limiter{max: max, window: window, hits: map[string]*bucket{}}
}

// Allow records an attempt and reports whether it is within the limit.
func (l *Limiter) Allow(key string) bool {
	l.mu.Lock()
	defer l.mu.Unlock()
	now := time.Now()
	b, ok := l.hits[key]
	if !ok || now.After(b.reset) {
		l.hits[key] = &bucket{count: 1, reset: now.Add(l.window)}
		l.sweep(now)
		return true
	}
	b.count++
	return b.count <= l.max
}

// Reset clears the counter after a successful login.
func (l *Limiter) Reset(key string) {
	l.mu.Lock()
	delete(l.hits, key)
	l.mu.Unlock()
}

func (l *Limiter) sweep(now time.Time) {
	if len(l.hits) < 1000 {
		return
	}
	for k, b := range l.hits {
		if now.After(b.reset) {
			delete(l.hits, k)
		}
	}
}
