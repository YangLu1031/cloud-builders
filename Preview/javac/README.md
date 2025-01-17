# javac

This `javac` build step is based on the `openjdk` image supplied by the OpenJDK
community at https://hub.docker.com/_/openjdk.

The OpenJDK community additionally supports multiple tagged versions across
multiple versions of Java and various platforms, as well as additional tooling.
For details, please visit https://hub.docker.com/_/openjdk.

To migrate from `gcr.io/cloud-builders/javac` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/javac'
+ name: '{region}-docker.pkg.dev/cloud-builders/preview/javac'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/preview/javac'
  args: ['*.java']
```

Using a tagged `javac` version:
```yaml
steps:
- name: 'openjdk:16-slim-buster'
  args: ['*.java']
  entrypoint: 'javac'
```

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that uses `javac` to
compile a simple Java program. The second step uses the `java` runtime included
with the OpenJDK to execute the compiled Java program. The example can be
executed via:
```
gcloud builds submit --config=example.yaml example
```
