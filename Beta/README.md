# Artifact Registry Beta

This repository reflects the upcoming Beta release of cloud-builders to
[Artifact Registry](https://cloud.google.com/artifact-registry).

## Setup

To set up Artifact Registry in your Google Cloud Platform project, use the
script in the setup directory. This only needs to be done once.

## Build and push the images

Build and push all images by running:
`gcloud builds submit --config=nightly-build.yaml`
in this directory.

## TODO

- Add all the images.
- Automate!
