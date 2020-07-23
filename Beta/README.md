# Beta Cloud Builders

This repository reflects the upcoming Beta release of cloud-builders to
[Artifact Registry](https://cloud.google.com/artifact-registry).

## Background

TODO: Explain the reasons for the migration and what is changing.

## Setup

To set up Artifact Registry in your Google Cloud Platform project, use the
script in the setup directory. This only needs to be done once.

## Build and push the images

Build and push all images by running:
`gcloud builds submit --config=nightly-build.yaml`
in this directory.

## TODO

- Add images for wget, firebase.
- Migrate gcs-fetcher and gke-deploy to AR.
- Automate all the things!
    - set up notifications on failure https://cloud.google.com/cloud-build/docs/configuring-notifications/configure-smtp
    - set up PR builds
