# mvn

This `mvn` build step is based on the `maven` image supplied by the Maven
community at https://hub.docker.com/_/maven.

The Maven community provides additional `maven` images that support multiple
tagged versions of Maven across multiple versions of Java and multiple
platforms. Please visit https://hub.docker.com/_/maven for details.

To migrate from `gcr.io/cloud-builders/mvn` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/mvn'
+ name: '{region}-docker.pkg.dev/gcb-release/cloud-builders/mvn'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/mvn'
  args: ['install']
```

Using a tagged `mvn` version:
```yaml
steps:
- name: 'maven:3.6-openjdk-11'
  args: ['install']
  entrypoint: 'mvn'
```
