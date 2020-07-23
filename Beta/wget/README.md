# wget

This `wget` build step is based on the `launcher.gcr.io/google/ubuntu1804` image
supplied in the Google Cloud Marketplace at
https://console.cloud.google.com/marketplace/details/ubuntu-os-cloud/ubuntu-xenial.

This builder simply invokes the [`wget`](https://www.gnu.org/software/wget/)
command. Arguments passed to this builder will be passed to `wget` directly.

Substantially similar functionality can be found using `curl`. While `curl`
does not offer `wget`'s ability to recursively traverse a website, `curl`
offers substantially more options for more internet protocols. `curl` is also
available in a variety of versions across multiple platforms in
community-maintained `curl` images; see the [`curl
README`](https://github.com/GoogleCloudPlatform/cloud-builders/tree/master/curl)
for details.

Note that if `curl` is not a better option, `wget` is available in the official
community-supported [`alpine`](https://hub.docker.com/_/alpine) and
[`busybox`](https://hub.docker.com/_/busybox) images on Dockerhub, both of which
provide a variety of tagged versions. However, these may not be the
fully-featured GNU version of `wget`.

To migrate from `gcr.io/cloud-builders/wget` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/wget'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/wget'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

Fetch the content of a file by URL. The file must be publicly readable since no
credentials are passed in the request.
```
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/wget'
  args: ['-O', 'localfile.zip', 'http://www.example.com/remotefile.zip']
- name: 'alpine'
  entrypoint: 'wget'
  args: ['-O', 'localfile.zip', 'http://www.example.com/remotefile.zip']
- name: 'busybox'
  entrypoint: 'wget'
  args: ['-O', 'localfile.zip', 'http://www.example.com/remotefile.zip']
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/curl'
  args: ['-o', 'localfile.zip', 'http://www.example.com/remotefile.zip']
```

Send a `POST` request to a URL, including the `$BUILD_ID` in the payload.
```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/wget'
  args: ['-q', '--post-data="{\"id\":\"$BUILD_ID\"}"', 'http://www.example.com']
- name: 'alpine'
  entrypoint: 'wget'
  args: ['-q', '--post-data="{\"id\":\"$BUILD_ID\"}"', 'http://www.example.com']
- name: 'busybox'
  entrypoint: 'wget'
  args: ['-q', '--post-data="{\"id\":\"$BUILD_ID\"}"', 'http://www.example.com']
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/curl'
  args: ['--data-raw', '"id=$BUILD_ID"', 'http://www.example.com']
```
