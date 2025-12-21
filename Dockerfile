ARG FLAVOR=catppuccin-frappe
ARG URL="https://github.com/catppuccin/plymouth"
ARG REV="HEAD"
FROM busybox:latest AS builder
RUN <<EORUN
set -euxo pipefail
THEME="catppuccin-${FLAVOR}"
apk add --no-cache git
mkdir /w && cd /w
git clone "${URL}" . --no-checkout --filter=blob:none
git checkout "${REV}"
EORUN
FROM scratch
COPY --from=builder /w/themes/${FLAVOR}/ /usr/share/plymouth/themes/${FLAVOR}
COPY <<EOF /etc/plymouth/plymouthd.conf
# From the catppuccin-plymouth OCI package
[Theme]
Theme="${FLAVOR}"
EOF
