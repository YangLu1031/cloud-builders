# helm

This `helm` build step is based on the `gcr.io/k8s-skaffold/skaffold` image
supplied by the GoogleContainerTools team at
https://github.com/GoogleContainerTools/skaffold.

The GoogleContainerTools team additionally supports multiple tagged versions of
the `gcr.io/k8s-skaffold/skaffold` image as well as additional Kubernetes
tooling. For details, please visit
https://github.com/GoogleContainerTools/skaffold.

This image is available as
`{region}-docker.pkg.dev/cloud-builders/preview/helm` where {region} is
one of `us`, `europe`, or `asia`. Choose the closest region to where your builds
are executed.

For information on `helm`, please visit https://helm.sh/.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/preview/helm'
  args: ['get', 'all', '${RELEASE_NAME}']
```

Using a tagged `helm` version:
```yaml
steps:
- name: 'gcr.io/k8s-skaffold/skaffold:v1.12.1'
  args: ['get', 'all', '${RELEASE_NAME}']
  entrypoint: 'helm'
```

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that uses `helm` to
search for wordpress charts.  It can be executed via:
```
gcloud builds submit --config=example.yaml --no-source
```
