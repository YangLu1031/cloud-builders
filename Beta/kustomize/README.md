# kustomize

This `kustomize` build step is based on the `gcr.io/k8s-skaffold/skaffold` image
supplied by the GoogleContainerTools team at
https://github.com/GoogleContainerTools/skaffold.

The GoogleContainerTools team additionally supports multiple tagged versions of
the `gcr.io/k8s-skaffold/skaffold` image as well as additional Kubernetes
tooling. For details, please visit
https://github.com/GoogleContainerTools/skaffold.

This image is available as
`{region}-docker.pkg.dev/gcb-release/cloud-builders/kustomize` where {region}
is one of `us`, `europe`, or `asia`. Choose the closest region to where your
builds are executed.

For information on `kustomize`, please visit https://sigs.k8s.io/kustomize.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/kustomize'
  args: ['build', 'github.com/kubernetes-sigs/kustomize/examples/multibases/dev/']
```

Using a tagged `kustomize` version:
```yaml
steps:
- name: 'gcr.io/k8s-skaffold/skaffold:v1.12.1'
  args: ['build', 'github.com/kubernetes-sigs/kustomize/examples/multibases/dev/']
  entrypoint: 'kustomize'
```
