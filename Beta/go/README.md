# go

This `go` build step is based on the `golang` image supplied by the Go team
at https://hub.docker.com/_/golang.

The Go team additionally supports multiple tagged versions across multiple
platforms. For details, please visit https://hub.docker.com/_/golang.

To migrate from `gcr.io/cloud-builders/go` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/go'
+ name: '{region}-docker.pkg.dev/gcb-release/cloud-builders/go'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/go'
  args: ['get', 'golang.org/x/net/context']
  env: ['GOPATH=/tmp']
```

Using a tagged `go` version:
```yaml
steps:
- name: 'golang:1.14.6-buster'
  entrypoint: 'go'
  args: ['get', 'golang.org/x/net/context']
  env: ['GOPATH=/tmp']
```

## Example `listbuilds.yaml`

This directory contains an example [`listbuilds.yaml`](listbuilds.yaml) that
compiles and runs a `go` program to list builds. The `go` code is in the
[`example`](example) directory.  You can run this example by running the
following command in this directory:
```
gcloud builds submit --config=listbuilds.yaml example
```
This `listbuilds.yaml`:

1. fetches `go` dependencies. Note the global `GOPATH` setting which applies to
   all build steps and places the `GOPATH` into the persistent `/workspace`
   directory.
1. builds and runs a `go` executable using the `go` builder.
1. cross-compiles a `go` executable for packaging into a minimalist `Docker`
   container.
1. performs a `docker build` to package the executable; note that the packaging
   also includes `ca-certificates.crt` which are not present in the `scratch`
   container but are needed by the `listbuilds` executable to make Google API
   calls. See the [`Dockerfile`](example/Dockerfile) for details.
1. runs the built `Docker` container to confirm that it works.
