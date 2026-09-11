package auth

import (
	"context"
	"log/slog"
	"runtime/debug"
	"strings"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
)

// freeMethods need no session token.
var freeMethods = map[string]bool{
	"Register":              true,
	"Login":                 true,
	"RequestRecovery":       true,
	"ValidateRecoveryToken": true,
	"RecoverAccount":        true,
	"BeginPasskeyLogin":     true,
	"FinishPasskeyLogin":    true,
}

// Interceptor validates the `authorization` metadata and injects the user id into the context.
func Interceptor(tokens *Tokens) grpc.UnaryServerInterceptor {
	return func(ctx context.Context, req any, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (any, error) {
		method := info.FullMethod[strings.LastIndex(info.FullMethod, "/")+1:]
		if freeMethods[method] {
			return handler(ctx, req)
		}
		md, _ := metadata.FromIncomingContext(ctx)
		values := md.Get("authorization")
		if len(values) == 0 || values[0] == "" {
			return nil, status.Error(codes.Unauthenticated, "missing token")
		}
		raw := strings.TrimSpace(strings.TrimPrefix(values[0], "Bearer "))
		userID, err := tokens.Parse(raw)
		if err != nil {
			return nil, status.Error(codes.Unauthenticated, "invalid or expired token")
		}
		return handler(WithUserID(ctx, userID), req)
	}
}

// Recovery converts panics into Internal errors so one bad request cannot take the server down.
func Recovery(ctx context.Context, req any, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (resp any, err error) {
	defer func() {
		if r := recover(); r != nil {
			slog.Error("[PANIC]", "method", info.FullMethod, "panic", r, "stack", string(debug.Stack()))
			err = status.Error(codes.Internal, "internal server error")
		}
	}()
	return handler(ctx, req)
}

// Logging records each call with its duration and status code.
func Logging(ctx context.Context, req any, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (any, error) {
	start := time.Now()
	resp, err := handler(ctx, req)
	code := status.Code(err)
	method := info.FullMethod[strings.LastIndex(info.FullMethod, "/")+1:]
	if err != nil && code != codes.Unauthenticated && code != codes.NotFound && code != codes.InvalidArgument {
		slog.Warn("[RPC]", "method", method, "code", code.String(), "ms", time.Since(start).Milliseconds(), "err", err)
	} else {
		slog.Debug("[RPC]", "method", method, "code", code.String(), "ms", time.Since(start).Milliseconds())
	}
	return resp, err
}
