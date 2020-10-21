# go

This `go` build step is based on the `golang` image supplied by the Go team
at https://hub.docker.com/_/golang.

The Go team additionally supports multiple tagged versions across multiple
platforms. For details, please visit https://hub.docker.com/_/golang.

To migrate from `gcr.io/cloud-builders/go` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
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

## Example `listbuilds.yaml`

This directory contains an example [`listbuilds.yaml`](listbuilds.yaml) that
compiles and runs a `go` program to list builds. The `go` code is in the
[`listbuilds`](listbuilds) directory.  You can run this example by running the
following command in this directory:
```
gcloud builds submit --config=listbuilds.yaml listbuilds
```
The example builds `listbuilds`, packages it into a minimalist Docker container,
and runs the built container to confirm that it works.

The [`Dockerfile`](listbuilds/Dockerfile) used does a multi-stage Docker build that
results in a minimalist container for the given executable. To do this, it:

1. uses `go get` to fetch dependencies.
1. cross-compiles the `listbuilds` executable for packaging into a minimalist
   `Docker` container based on the empty `scratch` image.
1. packages the executable. Note that the packaging also includes
   `ca-certificates.crt` which are not otherwise present in the `scratch`
   container but are needed to make Google API calls.
