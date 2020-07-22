# Docker

This `docker` builder is based on the `docker` image supplied by the Docker team
at https://hub.docker.com/_/docker.

The Docker Team additionally supports multiple tagged versions as well as
additional Docker tooling. For details, please visit
https://hub.docker.com/_/docker.

To migrate from `gcr.io/cloud-builders/docker` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/docker'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/docker'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/docker'
  args: ['build', '-t', '...']
```

Using a tagged docker version:
```yaml
steps:
- name: 'docker:stable-git'
  args: ['build', '-t', '...']
  entrypoint: 'docker'
```

## Credentials

When used on the hosted Cloud Build service, this build step is automatically
set up with credentials for your [Cloud Build Service
Account](https://cloud.google.com/cloud-build/docs/permissions).  These
permissions are sufficient to interact directly with both GCR and Artifact
Registry.
