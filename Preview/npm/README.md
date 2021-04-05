# npm

This `npm` build step is based on the `node` image supplied by the Node
community at https://hub.docker.com/_/node.

The Node community provides `node` images that support multiple tagged versions
of `npm` and additional Node tooling. Please visit https://hub.docker.com/_/node
for details.

To migrate from `gcr.io/cloud-builders/npm` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/npm'
+ name: '{region}-docker.pkg.dev/gcb-release/cloud-builders/npm'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/npm'
  args: ['install']
```

Using a tagged `npm` version:
```yaml
steps:
- name: 'node:14.5.0'
  args: ['install']
  entrypoint: 'npm'
```

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that installs and runs
a Node "Hello World" using `npm`. It can be executed via:
```bash
gcloud builds submit --config=example.yaml --no-source
```

## Example `listbuilds.yaml`

This directory contains an example [`listbuilds.yaml`](listbuilds.yaml) that
uses `npm` to build and run a Node.js script to list builds. The code is in the
[`listbuilds`](listbuilds) directory.  You can run this example by running the
following command in this directory:
```bash
gcloud builds submit --config=listbuilds.yaml listbuilds
```
