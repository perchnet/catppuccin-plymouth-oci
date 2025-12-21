ARG FLAVOR
ARG URL
ARG REV
FROM alpine:latest AS builder
ENV FLAVOR=${FLAVOR:-catppuccin-frappe}
ENV URL="${URL:-https://github.com/catppuccin/plymouth}"
ENV REV="${REV:-HEAD}"
RUN <<EORUN
set -euxo pipefail
THEME="${FLAVOR}"
apk add --no-cache git
mkdir /w && cd /w
git clone "${URL}" . --no-checkout --filter=blob:none
git checkout "${REV}"
EORUN
ARG FLAVOR=${FLAVOR:-catppuccin-frappe}
FROM scratch
COPY --from=builder /w/themes/${FLAVOR}/ /usr/share/plymouth/themes/${FLAVOR}
COPY <<EOF /etc/plymouth/plymouthd.conf
# From the catppuccin-plymouth OCI package
[Theme]
Theme="${FLAVOR}"
EOF
