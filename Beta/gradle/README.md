# gradle

This `gradle` build step is based on the `gradle` image supplied by the Gradle
community at https://hub.docker.com/_/gradle.

The Gradle team provides `gradle` images that support multiple tagged versions
across multiple versions of Java and multiple platforms. Please visit
https://hub.docker.com/_/gradle for details.

To migrate from `gcr.io/cloud-builders/gradle` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/gradle'
+ name: '{region}-docker.pkg.dev/gcb-release/cloud-builders/gradle'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/gradle'
  args: ['...']
```

Using a tagged `gradle` version:
```yaml
steps:
- name: 'gradle:6.5.1-jdk8'
  args: ['...']
```

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that runs two simple
`gradle` build scripts. It can be executed via:
```
gcloud builds submit --config=example.yaml example
```
