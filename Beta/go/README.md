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
