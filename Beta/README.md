# Beta Cloud Builders

This directory previews the upcoming Beta release of Cloud Builders to [Artifact
Registry](https://cloud.google.com/artifact-registry).

This repository contains sample code for an upcoming Beta release of a new set
of Cloud Builders. Pre-GA products and features may have limited support, and
changes to pre-GA products and features may not be compatible with other pre-GA
versions. For more information, see the [launch stage
descriptions](https://cloud.google.com/products?hl=en#product-launch-stages) for
Google Cloud products and services.

## TL;DR

The Cloud Builders defined in this repository will eventually replace those
currently in use. They are generally -- but not always -- drop-in replacements
for the existing Cloud Builders.

Users need not take any action to migrate away from the existing Cloud Builders,
which will be maintained for the foreseeable future. However, we believe that
migration from the [existing Cloud Builders](..) will offer numerous benefits to
the users of the hosted Cloud Build service.

## Advantages

The main advantage to this new set of images comes from the strength of the
communities maintaining the tools. This community support allows the hosted
Google Cloud Build service to maintain a more up-to-date set of tools available
for use. Specifically, the following named versions will be available:

- `:latest`: For users who simply want the latest version of a given tool, the
  `:latest` tag of the released Cloud Builder image will generally be kept in
  sync with the most recent release of the given tool. Using this tag will keep
  you up-to-date, albeit at the expense of forfeiting control over the specific
  tool version in use.
- `:YYYYMMDD`: In the event of an incompatibility in a new release, a dated
  daily `:YYYYMMDD` tag will be available for pinning to a particular dated
  release. This allows easy debugging and rollback for situations where your
  build worked fine yesterday and mysteriously broke today. A given `:YYYYMMDD`
  image reflects what was `:latest` on the given date. Dated images will be
  deleted after nine months.
- `:stable`: For users who want to be up-to-date but would like additional
  vetting before adopting a new version, the `:stable` tag will be applied to
  images that have been through compatibility testing with Google Cloud Build.
  This enables you to remain generally up-to-date by rolling forward at least
  monthly to an image version that is confirmed as working with GCB.
- `:stable-YYYYMMDD`: Like the generic `:YYYYMMDD` tag, the `:stable-YYYYMMDD`
  tracks what was considered `:stable` on the given date, enabling both pinning
  to a dated stable version and ease of rollback. Again, these dated images will
  be deleted after nine months.
- Other versions. The directory for each Cloud Builder identifies the image
  source. Users who would like to pin a more particular version can generally
  use the source image as a drop-in replacement for the Cloud Builder. Each tool
  provides an example using the Cloud Builder hosted image as well as a
  versioned image from the source repository.

## New Images

Migrating to community-maintained images enables us to onboard new tools in the
Cloud Builders repository. The Beta images include the following tools that were
not included in the original set of Cloud Builders:

- [`helm`](helm)
- [`kpt`](kpt)
- [`kustomize`](kustomize)
- [`python`](python)
- [`skaffold`](skaffold)
- [`terraform`](terraform)

## Migration

The [existing set of Cloud Builders](..) is hosted in Google Cloud Repository in
the `gcr.io/cloud-builders/...` namespace. This new set of Beta Cloud Builders
will be released in two phases.

### Phase 1: Beta Builders in Artifact Registry

The initial release of these Beta Builders will be hosted in [Artifact
Registry](https://cloud.google.com/artifact-registry). We anticipate using the
namespace `{region}-docker.pkg.dev/gcb-release/cloud-builders/...` where
`{region}` is one of `us`, `europe`, or `asia`. To migrate to the new version of
a given Cloud Builder used on the hosted Cloud Build service, just change your
Build Step like this:

```diff
- name: 'gcr.io/cloud-builders/$TOOLNAME'
+ name: '$REGION-docker.pkg.dev/gcb-release/cloud-builders/$TOOLNAME'
```

### Phase 2: GA Release of new Builders

After Artifact Registry reaches GA, we expect to release a new set of images
using the GA Artifact Registry repository. At this time, we expect these images
to be 100% compatible with the Beta Builders, but we do expect them to be in a
new repository namespace.

### Compatibility

For most users, the Beta Builders are compatible as a drop-in replacement for
your existing Cloud Builder usage; simply change the image name and the Beta
Builder will work fine. The known potential areas of incompatibility are as
follows:

- Version differences. The Beta Builder may use a different tool version than
  the existing Cloud Builder, and the version may have incompatible changes.
- Use of `entrypoint:` in a Build Step. Because some Beta Builders use different
  base images, your existing `entrypoint:` may not be available in the Beta
  replacement or may not be compatible with your existing usage.
- Platform differences: some of the Beta Builders use a different operating
  system in their base image, and the change of OS or platform may result in
  different behavior from the existing Cloud Builder image.

Our analysis of usage of Cloud Builders with the hosted Cloud Build service
reveals that only a small number of users will experience incompatible changes.
When compatibility issues surface that go beyond the three general issues noted
above (tool version, `entrypoint`, and OS or platform), we will add notes to the
relevant `README` for the tool to highlight these issues.

### Migration Paths

Different users will choose different strategies in choosing what images to use
and when, if ever to migrate from the existing Cloud Builders.

#### Leading Edge Beta Adoption

Those who wish to reap the benefits of up-to-date community-supported images can
migrate to the Beta Builders when released. These users will get the early
benefit of the new images, albeit at the cost of potential friction in adoption.
We expect to keep the Beta namespace in place even after moving the images to
GA, but as with all Beta software, the Beta images may be discontinued or
experience unstable breaking changes. Note that the dated images described above
mitigate against such issues.

#### GA Release

Users interested in a more stable experience can await the GA release of these
Beta Builders. The existing `gcr.io/cloud-builders/...` images will continue to
be maintained for the foreseeable future.

#### Direct Use of Community-Supported Images

Some users may wish to have complete control over tool versioning, including the
ability to choose among the matrix of available tool, platform, and operation
system versions and options. For such users, we recommend migration away from
both the existing Cloud Builders and these new Beta Builders by going directly
to the community-supported container images for the underlying tools.

For example, the Maven Project supports over 100 versioned combinations of
Maven, Java, JDK/JRE, and platform on
[DockerHub](https://hub.docker.com/_/maven). You can choose the exact desired
combination and have complete control over version adoption and migration in the
build system.

Each tool in the Beta Builders provides example usage for both the Beta Builder
and the underlying versioned tool.

## Background

When we first launched the Cloud Builders repository in 2015, the Docker
container ecosystem did not have the maturity that we see today. Most of the
tools that we wanted to make available as Build Steps for [Google Cloud
Build](https://cloud.google.com/cloud-build/docs/) did not yet exist in
well-maintained public Docker images, so we created this Cloud Builders
repository and created an initial set of Build Steps that we thought would be
useful with the hosted service. As usage grew, we augmented that set of Cloud
Builders with the [Cloud Builders Community
respository](https://github.com/GoogleCloudPlatform/cloud-builders-community).

Since then, the adoption of containerized tools has grown exponentially, and the
containerized-tool model is now the standard that we see in numerous cloud-based
CI/CD systems. Along with the adoption of the model, communities have formed to
support well-maintained versions of most development tools.

------
## Adding Builders

To add a new builder:

- Add an appropriately-named sub-directory.
- Add a `Dockerfile`, `README.md`, and `.gcloudignore` in it.
- Profit!

### Adding additional tooling to a builder

Sometimes it is advantageous to have multiple versions of a builder; for
example, [`mvn`](mvn) supports a `mvn:appengine` image with a pre-installed App
Engine plug-in. To add a specialized version with additional tooling, just add
another `Dockerfile` -- like `Dockerfile.appengine` -- in the builder directory.

------
# Hosting Your Own Builders

This section is for users who want to host their own versions of the builders
herein. Users of these Build Steps need not be familiar with this section.

## Setup

If you want to host your own version of these images in Artifact Registry in
your Google Cloud Platform project, use the script in the setup directory. This
only needs to be done once.

## Build the images

Build all the images in this repository by running the following command in this
directory:
```bash
gcloud builds submit
```

To build the images and push them to your Artifact Registry repositories (see
the [`setup`](setup) subdirectory to set up the appropriate repositories), run:
```bash
gcloud builds submit \
    --substitutions=_PUSH=true,_REGISTRIES=us-docker.pkg.dev/${PROJECT_ID}/<your-registry>
```

Note that you can push to multiple registries in a single build like so:
```bash
gcloud builds submit \
    --substitutions="_PUSH=true,_REGISTRIES=us-docker.pkg.dev/${PROJECT_ID}/<your-registry> europe-docker.pkg.dev/${PROJECT_ID}/<your-registry>"
```

## TODO

- Add image for firebase.
- Automate all the things!
    - set up notifications on failure
      https://cloud.google.com/cloud-build/docs/configuring-notifications/configure-smtp
    - set up PR builds
    - set up tests prior to push
    - set up `:stable` tags
