# skaffold

This `skaffold` build step is based on the `gcr.io/k8s-skaffold/skaffold` image
supplied by the GoogleContainerTools team at
https://github.com/GoogleContainerTools/skaffold.

The GoogleContainerTools team additionally supports multiple tagged versions of
the `gcr.io/k8s-skaffold/skaffold` image as well as additional Kubernetes
tooling. For details, please visit
https://github.com/GoogleContainerTools/skaffold.

This image is available as
`{region}-docker.pkg.dev/cloud-builders/cloud-builders/skaffold` where {region} is
one of `us`, `europe`, or `asia`. Choose the closest region to where your builds
are executed.

For information on `skaffold`, please visit https://skaffold.dev/.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/skaffold'
  args: ['build']
```

Using a tagged `skaffold` version:
```yaml
steps:
- name: 'gcr.io/k8s-skaffold/skaffold:v1.12.1'
  args: ['build']
  entrypoint: 'skaffold'
```
