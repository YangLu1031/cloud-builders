# Build the `listbuilds` executable.
FROM us-docker.pkg.dev/bendory-cloud-builders/cloud-builders/go as builder
RUN go get -v google.golang.org/api/cloudbuild/v1
COPY listbuilds.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main listbuilds.go

# Package `listbuilds` into a minimalist container.
FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/main /usr/local/bin/listbuilds
ENTRYPOINT ["/usr/local/bin/listbuilds"]
