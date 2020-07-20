# Set Up Artifact Registry

This directory contains scripts for setting up a new Artifact Registry repository suitable for hosting the Beta Artifact Registry cloud-builder images.

## Before you begin

Follow these instructions to set up the Google Cloud SDK, the `docker` CLI, and your Google Cloud Project for Artifact Registry use.
https://cloud.google.com/artifact-registry/docs/docker/quickstart#before-you-begin

## Run this script

```
gcloud services enable artifactregistry.googleapis.com
gcloud beta artifacts repositories create cloud-builders --repository-format=docker --location=us
gcloud beta artifacts repositories create cloud-builders --repository-format=docker --location=europe
gcloud beta artifacts repositories create cloud-builders --repository-format=docker --location=asia
gcloud beta artifacts repositories list
```
