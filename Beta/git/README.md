# git

This `git` builder is based on the `gcr.io/google.com/cloudsdktool/cloud-sdk`
image supplied by the Google Cloud SDK team and configured to run `git` using
[Application Default
Credentials](https://cloud.google.com/docs/authentication/production) when
running in the hosted Cloud Build service. This provides authentication for
interacting with Google Cloud Source Repositories. Visit
https://github.com/GoogleCloudPlatform/cloud-sdk-docker for details on the base
image.

To migrate from `gcr.io/cloud-builders/git` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/git'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/git'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/git'
  args: ['clone', 'https://source.developers.google.com/p/$PROJECT_ID/r/$REPO']
```
