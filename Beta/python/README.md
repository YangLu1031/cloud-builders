# python

This `python` build step is based on the `python` image supplied by the python
community at https://hub.docker.com/_/python.

The python team additionally supports multiple tagged versions of python across
various platforms and OS versions.  For details, please visit
https://hub.docker.com/_/python.

This image is available as
`{region}-docker.pkg.dev/gcb-release/cloud-builders/python` where {region} is
one of `us`, `europe`, or `asia`. Choose the closest region to where your builds
are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/python'
  args: ['hello.py']
```

Using a tagged `python` version:
```yaml
steps:
- name: 'python:3.9.0b5-buster'
  args: ['hello.py']
  entrypoint: 'python'
```

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that installs and runs
a simple "Hello World" using `python`. It can be executed via:
```
gcloud builds submit --config=example.yaml --no-source
```
