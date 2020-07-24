# yarn

This `yarn` build step is based on the `node` image supplied by the Node
community at https://hub.docker.com/_/node.

The Node community provides `node` images that support multiple tagged versions
of `yarn` and additional Node tooling. Please visit https://hub.docker.com/_/node
for details.

To migrate from `gcr.io/cloud-builders/yarn` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/yarn'
+ name: '{region}-docker.pkg.dev/gcb-release/cloud-builders/yarn'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/yarn'
  args: ['install']
```

Using a tagged `yarn` version:
```yaml
steps:
- name: 'node:14.5.0'
  args: ['install']
  entrypoint: 'yarn'
```
