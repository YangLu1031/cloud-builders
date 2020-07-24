# gradle

This `gradle` build step is based on the `gradle` image supplied by the Gradle
community at https://hub.docker.com/_/gradle.

The Gradle team provides `gradle` images that support multiple tagged versions
across multiple versions of Java and multiple platforms. Please visit
https://hub.docker.com/_/gradle for details.

To migrate from `gcr.io/cloud-builders/gradle` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/gradle'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/gradle'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/gradle'
  args: ['...']
```

Using a tagged `gradle` version:
```yaml
steps:
- name: 'gradle:6.5.1-jdk8'
  args: ['...']
  entrypoint: 'gradle'
```