# gcs-fetcher

This `gcs-fetcher` build step is identical to [gcs-fetcher](../gcs-fetcher) but
is regionally distributed alongside our Cloud Builders.

To migrate from `gcr.io/cloud-builders/gcs-fetcher` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/gcs-fetcher'
+ name: '{region}-docker.pkg.dev/cloud-builders/preview/gcs-fetcher'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

For usage information and examples, please refer to [the existing
documentation](../gcs-fetcher).
