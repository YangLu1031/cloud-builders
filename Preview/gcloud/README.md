# gcloud

This `gcloud` build step is based on the
`gcr.io/google.com/cloudsdktool/cloud-sdk` image supplied by the Google Cloud
SDK team.  Please visit https://github.com/GoogleCloudPlatform/cloud-sdk-docker
for details.

The Cloud SDK team additionally supports multiple tagged versions of `gcloud`
across multiple platforms. For details, please visit
https://github.com/GoogleCloudPlatform/cloud-sdk-docker.

To migrate from `gcr.io/cloud-builders/gcloud` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/gcloud'
+ name: '{region}-docker.pkg.dev/gcb-release/cloud-builders/gcloud'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/gcloud'
  args: ['builds', 'list']
```

Using a tagged `gcloud` version:
```yaml
steps:
- name: 'gcr.io/google.com/cloudsdktool/cloud-sdk:300.0.0'
  args: ['builds', 'list']
  entrypoint: 'gcloud'
```

## Example `listbuilds.yaml`

To help you get started with `gcloud` as a build step, this directory contains
an example [`listbuilds.yaml`](listbuilds.yaml) that uses `gcloud` to list
builds. You can run this example by running the following command in this
directory:
```
gcloud builds submit --config=listbuilds.yaml --no-source
```
