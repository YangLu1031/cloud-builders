# curl

This `curl` build step is based on the `curlimages/curl` image maintained by the
curlimages community on Dockerhub. Visit
https://hub.docker.com/r/curlimages/curl for details.

The `curlimages` community supports multiple tagged versions of curl across
multiple operating systems as `curlimages/curl`. While these images are
compatible with the hosted Cloud Build service, they run as user `curl_user` and
thus may not be suitable for all purposes. For details, please visit
https://hub.docker.com/r/curlimages/curl.

To migrate from `gcr.io/cloud-builders/curl` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/curl'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/curl'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/curl'
  args: ['http://www.example.com/']
```

Using a tagged `curl` version:
```yaml
steps:
- name: 'curlimages/curl:7.71.0'
  args: ['http://www.example.com/']
  entrypoint: 'curl'
```
