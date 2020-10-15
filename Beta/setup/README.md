# Set Up Artifact Registry

This directory contains scripts for setting up a new Artifact Registry
repository suitable for hosting the Beta Artifact Registry cloud-builder images.

## Before you begin

Follow these instructions to set up the Google Cloud SDK, the `docker` CLI, and
your Google Cloud Project for Artifact Registry use.
https://cloud.google.com/artifact-registry/docs/docker/quickstart#before-you-begin

## Run this script

```
# Enable the APIs
gcloud services enable cloudbuild.googleapis.com --async
gcloud services enable artifactregistry.googleapis.com
for location in us europe asia; do
  # Create the Repository
  gcloud beta artifacts repositories create cloud-builders --repository-format=docker --location=$location
  # Make the repository publicly readable
  gcloud beta artifacts repositories add-iam-policy-binding cloud-builders --member='allUsers' --role='roles/artifactregistry.reader' --location=$location
done
```

## Confirm that the repositories were created
You can see all your repositories across all locations with:
`gcloud beta artifacts repositories list`

## Set up auth for local docker use (optional)
This command configures your local installation to use Application Default
Credentials with Artifact Registry:
`gcloud auth configure-docker us-docker.pkg.dev,europe-docker.pkg.dev,asia-docker.pkg.dev --quiet`
