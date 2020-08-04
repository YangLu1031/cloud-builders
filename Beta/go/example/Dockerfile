# Build a staticly-linked `listbuilds` executable suitable for running in an
# otherwise (almost) empty container..
FROM us-docker.pkg.dev/bendory-cloud-builders/cloud-builders/go as builder
COPY listbuilds.go .
RUN go get -v \
	cloud.google.com/go/cloudbuild/apiv1 \
	cloud.google.com/go/compute/metadata \
	google.golang.org/api/iterator \
	google.golang.org/genproto/googleapis/devtools/cloudbuild/v1
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main listbuilds.go

# Package `listbuilds` into a minimalist container.
FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/main /usr/local/bin/listbuilds
ENTRYPOINT ["/usr/local/bin/listbuilds"]
