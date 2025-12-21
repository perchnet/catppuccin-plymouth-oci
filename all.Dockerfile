ARG FLAVOR
ARG URL
ARG REV
FROM alpine:latest AS builder
ENV URL="${URL:-https://github.com/catppuccin/plymouth}"
ENV REV="${REV:-HEAD}"
RUN <<EORUN
set -euxo pipefail
apk add --no-cache git
mkdir /w && cd /w
git clone "${URL}" . --no-checkout --filter=blob:none
git checkout "${REV}"
EORUN
FROM scratch
COPY --from=builder /w/themes /themes
