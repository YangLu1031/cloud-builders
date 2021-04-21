# gke-deploy

This `gke-deploy` build step is identical to [gke-deploy](../gke-deploy) but
is regionally distributed alongside our Cloud Builders.

To migrate from `gcr.io/cloud-builders/gke-deploy` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/gke-deploy'
+ name: '{region}-docker.pkg.dev/gcb-release/cloud-builders/gke-deploy'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

For usage information and examples, please refer to [the existing
documentation](../gke-deploy).
