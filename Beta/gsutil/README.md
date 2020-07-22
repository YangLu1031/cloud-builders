# gsutil

This `gsutil` build step is based on the
`gcr.io/google.com/cloudsdktool/cloud-sdk` image supplied by the Google Cloud
SDK team.  Please visit https://github.com/GoogleCloudPlatform/cloud-sdk-docker
for details.

The Cloud SDK team additionally supports multiple tagged versions of `gsutil`
across multiple platforms. For details, please visit
https://github.com/GoogleCloudPlatform/cloud-sdk-docker.

To migrate from `gcr.io/cloud-builders/gsutil` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/gsutil'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/gsutil'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/gsutil'
  args: ['cp', 'gs://mybucket/remotefile.zip', 'localfile.zip']
```

Using a tagged `gsutil` version:
```yaml
steps:
- name: 'gcr.io/google.com/cloudsdktool/cloud-sdk:300.0.0'
  args: ['cp', 'gs://mybucket/remotefile.zip', 'localfile.zip']
  entrypoint: 'gsutil'
```
