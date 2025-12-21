ARG BASE=ghcr.io/perchnet/catppuccin-plymouth-oci:latest
ARG FLAVOR=catppuccin-frappe
ARG REV=latest
FROM ${BASE} as BASE
FROM scratch
ENV FLAVOR=${FLAVOR}
COPY --from=BASE /themes/${FLAVOR}/ /usr/share/plymouth/themes/${FLAVOR}
COPY <<EOF /etc/plymouth/plymouthd.conf
# From the catppuccin-plymouth OCI package
[Theme]
Theme="${FLAVOR}"
EOF
