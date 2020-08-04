# Packaging of the listbuilds app into a minimal scratch container.
FROM scratch
ADD ca-certificates.crt /etc/ssl/certs/
COPY main /usr/local/bin/listbuilds
ENTRYPOINT "/usr/local/bin/listbuilds"
