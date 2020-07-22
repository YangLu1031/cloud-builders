# Bazel

This `bazel` build step is based on the `bazel` image supplied by Google's Bazel
team as described at
https://console.cloud.google.com/marketplace/details/google/bazel.

The Bazel Team additionally supports multiple tagged versions.
For details, please visit gcr.io/cloud-marketplace-containers/google/bazel.

To migrate from `gcr.io/cloud-builders/bazel` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/bazel'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/bazel'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/bazel'
  args: ['build', '//java/com/company/service:server']
```

Using a tagged bazel version:
```yaml
steps:
- name: 'gcr.io/cloud-marketplace/google/bazel:3.3.0'
  args: ['build', '//java/com/company/service:server']
  entrypoint: 'bazel'
```
