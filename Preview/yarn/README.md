# yarn

This `yarn` build step is based on the `node` image supplied by the Node
community at https://hub.docker.com/_/node.

The Node community provides `node` images that support multiple tagged versions
of `yarn` and additional Node tooling. Please visit https://hub.docker.com/_/node
for details.

To migrate from `gcr.io/cloud-builders/yarn` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
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

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that uses `yarn` to
run a "Hello World" package. It can be executed via:
```bash
gcloud builds submit --config=example.yaml example
```

## Example `listbuilds.yaml`

This directory contains an example [`listbuilds.yaml`](listbuilds.yaml) that
uses `yarn` to build and run a Node.js script to list builds. The code is in the
[`listbuilds`](listbuilds) directory.  You can run this example by running the
following command in this directory:
```bash
gcloud builds submit --config=listbuilds.yaml listbuilds
```
