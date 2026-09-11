# Builds the Flutter web app and serves it with Caddy, which also fronts the gRPC-Web proxy.
# Flutter is installed from the official repo at the exact version the project targets.
FROM docker.io/library/debian:bookworm-slim AS build
ARG FLUTTER_VERSION=3.47.2
RUN apt-get update && apt-get install -y --no-install-recommends git curl unzip xz-utils zip ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m flutter
# Run as a regular user: Flutter dislikes root, and rootless podman cannot chown extracted archives.
USER flutter
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git /home/flutter/sdk
ENV PATH="/home/flutter/sdk/bin:${PATH}"
RUN flutter config --no-analytics --enable-web && flutter precache --web
WORKDIR /app
COPY --chown=flutter pubspec.yaml pubspec.lock ./
RUN flutter pub get
COPY --chown=flutter . .
RUN flutter build web --release --dart-define=flavor=prod

FROM docker.io/library/caddy:2-alpine
COPY --from=build /app/build/web /srv
COPY Caddyfile /etc/caddy/Caddyfile
