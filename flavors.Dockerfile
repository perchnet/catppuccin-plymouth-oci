ARG FLAVOR=catppuccin-frappe
ARG REV=latest
FROM scratch
COPY --from=ghcr.io/perchnet/catppuccin-plymouth-oci:${REV} /usr/share/plymouth/themes/${FLAVOR}/ /usr/share/plymouth/themes/${FLAVOR}
COPY <<EOF /etc/plymouth/plymouthd.conf
# From the catppuccin-plymouth OCI package
[Theme]
Theme="${FLAVOR}"
EOF
