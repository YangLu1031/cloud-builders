# Build a staticly-linked `listbuilds` executable suitable for running in an
# otherwise (almost) empty container..
FROM us-docker.pkg.dev/cloud-builders/preview/go as builder

# Switch to a build directory; the golang container uses /go as its working
# directory, but is also GOPATH, which leads to errors with go modules.
WORKDIR /build
COPY listbuilds.go go.mod go.sum ./

# Download our dependencies from go.mod, then build.
RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main listbuilds.go

# Package the `listbuilds` artifact into a minimalist container.
# Certificates are required for GCP interactions.
FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /build/main /usr/local/bin/listbuilds
ENTRYPOINT ["/usr/local/bin/listbuilds"]
