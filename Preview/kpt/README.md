# kpt

This `kpt` build step is based on the `gcr.io/kpt-dev/kpt` image supplied by the
GoogleContainerTools team at https://github.com/GoogleContainerTools/kpt.

The GoogleContainerTools team additionally supports multiple tagged versions of
the `gcr.io/kpt-dev/kpt` image. For details, help, and usage information, please
visit https://github.com/GoogleContainerTools/kpt and/or
https://googlecontainertools.github.io/kpt/.

This image is available as
`{region}-docker.pkg.dev/cloud-builders/preview/kpt` where {region}
is one of `us`, `europe`, or `asia`. Choose the closest region to where your
builds are executed.


## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/preview/kpt'
  args: ['version']
```

Using a tagged `kpt` version:
```yaml
steps:
- name: 'gcr.io/kpt-dev/kpt:v0.37.1'
  args: ['version']
  entrypoint: 'kpt'
```
