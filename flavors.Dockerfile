ARG FLAVOR
FROM busybox as SCREAMING
ENV FLAVOR="${FLAVOR:-catppuccin-frappe}"
RUN <<EOR
mkdir /w
tee /w/plymouthd.conf <<EOT
# From the catppuccin-plymouth-oci:${FLAVOR} OCI package
[Theme]
Theme="${FLAVOR}"
EOT
EOR
ARG FLAVOR
FROM scratch
ENV FLAVOR="${FLAVOR:-catppuccin-frappe}"
COPY --from=SCREAMING /w/plymouthd.conf /etc/plymouth/plymouthd.conf
COPY --from=ghcr.io/perchnet/catppuccin-plymouth-oci:latest /themes/${FLAVOR}/ /usr/share/plymouth/themes/${FLAVOR}/
