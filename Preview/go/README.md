# go

This `go` build step is based on the `golang` image supplied by the Go team
at https://hub.docker.com/_/golang.

The Go team additionally supports multiple tagged versions across multiple
platforms. For details, please visit https://hub.docker.com/_/golang.

To migrate from `gcr.io/cloud-builders/go` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/go'
+ name: '{region}-docker.pkg.dev/cloud-builders/preview/go'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/preview/go'
  args: ['get', 'golang.org/x/net/context']
options:
  env: ['GOPATH=/workspace/go']
```

Using a tagged `go` version:
```yaml
steps:
- name: 'golang:1.14.6-buster'
  entrypoint: 'go'
  args: ['get', 'golang.org/x/net/context']
options:
  env: ['GOPATH=/workspace/go']
```

Note that both examples set `GOPATH` to `/workspace/go` as a global build
option. Because `/workspace` persists across all build steps, this means that
packages installed into the `GOPATH` will be available to all build steps.

The default GOPATH for these containers is set to `/go`; this is the `GOPATH`
used in the community-supported `golang` variations. While this will work in the
hosted GCB service in a single build step, it will not be persisted across build
steps, hence the use of `GOPATH=/workspace/go` in these examples.

## Example `listbuilds.yaml`

This directory contains an example [`listbuilds.yaml`](listbuilds.yaml) that
compiles and runs a `go` program to list builds. The `go` code is in the
[`listbuilds`](listbuilds) directory.  You can run this example by running the
following command in this directory:
```bash
gcloud builds submit --config=listbuilds.yaml listbuilds
```
The example builds `listbuilds`, packages it into a minimalist Docker container,
and runs the built container to confirm that it works.

This build is performed in two different ways to demonstrate usage.

### Build #1: Build executable, then package using `docker`

First [`listbuilds.yaml`](listbuilds.yaml) demonstrates use of the `go` builder
for a stand-alone build of `listbuilds.go` into a `main` executable. This
executable is built and tested, then packaged into a minimalist Docker container
using [`Dockerfile.simple`](listbuilds/Dockerfile.simple). Comments in
`listbuilds.yaml` explain each step.

### Build #2: build and package executable using a multi-stage Docker build

The [`Dockerfile.multi`](listbuilds/Dockerfile.multi) used does a multi-stage
Docker build that results in a minimalist container for the given executable. To
do this, it:

1. copies `go.mod` and `go.sum` into the container build context; these files
   define the needed [Go modules](https://blog.golang.org/using-go-modules).
1. uses `go get` to fetch dependencies.
1. cross-compiles the `listbuilds` executable for packaging into a minimalist
   `Docker` container based on the empty `scratch` image.
1. packages the executable. Note that the packaging also includes
   `ca-certificates.crt` which are not otherwise present in the `scratch`
   container but are needed to make Google API calls.
