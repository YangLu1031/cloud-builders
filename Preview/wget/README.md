# wget

This `wget` build step adds the GNU [`wget`](https://www.gnu.org/software/wget/)
command to a base `alpine` image.

Substantially similar functionality can be found using `curl`. While `curl` does
not offer `wget`'s ability to recursively traverse a website, `curl` offers
substantially more options for more internet protocols. `curl` is also available
in a variety of versions across multiple platforms in community-maintained
`curl` images; see the [`curl README`](../curl) for details.

To migrate from `gcr.io/cloud-builders/wget` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/wget'
+ name: '{region}-docker.pkg.dev/cloud-builders/preview/wget'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

Fetch the content of a file by URL. The file must be publicly readable since no
credentials are passed in the request.
```
steps:
- name: 'us-docker.pkg.dev/cloud-builders/preview/wget'
  args: ['-O', 'localfile.zip', 'http://www.example.com/remotefile.zip']
- name: 'us-docker.pkg.dev/cloud-builders/preview/curl'
  args: ['-o', 'localfile.zip', 'http://www.example.com/remotefile.zip']
```

Send a `POST` request to a URL, including the `$BUILD_ID` in the payload.
```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/preview/wget'
  args: ['-q', '--post-data="{\"id\":\"$BUILD_ID\"}"', 'http://www.example.com']
- name: 'us-docker.pkg.dev/cloud-builders/preview/curl'
  args: ['--data-raw', '"id=$BUILD_ID"', 'http://www.example.com']
```
