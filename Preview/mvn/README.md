# mvn

This `mvn` build step is based on the `maven` image supplied by the Maven
community at https://hub.docker.com/_/maven.

The Maven community provides additional `maven` images that support multiple
tagged versions of Maven across multiple versions of Java and multiple
platforms. Please visit https://hub.docker.com/_/maven for details.

To migrate from `gcr.io/cloud-builders/mvn` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
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

## Python, Cloud SDK, and App Engine use

The community-supported `maven` image no longer ships with `python`; this breaks
the [App Engine `maven`
plugin](https://cloud.google.com/appengine/docs/standard/java/using-maven).

This builder uses [`Dockerfile.appengine`](Dockerfile.appengine) to build an App
Engine-compatible image with the `:appengine` tag; it is available at
`{region}-docker.pkg.dev/gcb-release/cloud-builders/mvn:appengine`.

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that generates a `mvn`
project, builds and packages it, and finally executes a glorious "Hello World"
using the `java` runtime packaged alongside `mvn` in the build step.  It can be
executed via:
```bash
gcloud builds submit --config=example.yaml --no-source
```

## Example `listbuilds.yaml`

This directory contains an example [`listbuilds.yaml`](listbuilds.yaml) that
compiles and runs a Java program to list builds. The Java code and `maven`
configuration is in the [`listbuilds`](listbuilds) directory.  You can run this
example by running the following command in this directory:
```bash
gcloud builds submit --config=listbuilds.yaml listbuilds
```
The example builds `listbuilds.jar`, packages it into a Docker container with an
installed JRE, and then executes the built container to confirm that it works.
