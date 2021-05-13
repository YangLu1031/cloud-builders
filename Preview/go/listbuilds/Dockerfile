# Build a staticly-linked `listbuilds` executable suitable for running in an
# otherwise (almost) empty container..
FROM us-docker.pkg.dev/cloud-builders/preview/go as builder
WORKDIR /build
COPY listbuilds.go go.mod go.sum ./

RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main listbuilds.go

# Package `listbuilds` into a minimalist container.
FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /build/main /usr/local/bin/listbuilds
ENTRYPOINT ["/usr/local/bin/listbuilds"]
