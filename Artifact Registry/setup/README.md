# Set Up Artifact Registry

This directory contains scripts for setting up a new Artifact Registry repository suitable for hosting the Beta Artifact Registry cloud-builder images.

## Before you begin

Follow these instructions to set up the Google Cloud SDK, the `docker` CLI, and your Google Cloud Project for Artifact Registry use.
https://cloud.google.com/artifact-registry/docs/docker/quickstart#before-you-begin

## Run this script

```
# Enable the APIs
gcloud services enable cloudbuild.googleapis.com --async
gcloud services enable artifactregistry.googleapis.com
# Create the Repositoriews
gcloud beta artifacts repositories create docker --repository-format=docker --location=us
gcloud beta artifacts repositories create docker --repository-format=docker --location=europe
gcloud beta artifacts repositories create docker --repository-format=docker --location=asia
gcloud beta artifacts repositories list
# Set up auth (optional)
gcloud auth configure-docker us-docker.pkg.dev,europe-docker.pkg.dev,asia-docker.pkg.dev --quiet
# Make the repositories publicly readable
gcloud beta artifacts repositories add-iam-policy-binding docker --member='allUsers' --role='roles/artifactregistry.reader' --location=us
gcloud beta artifacts repositories add-iam-policy-binding docker --member='allUsers' --role='roles/artifactregistry.reader' --location=europe
gcloud beta artifacts repositories add-iam-policy-binding docker --member='allUsers' --role='roles/artifactregistry.reader' --location=asia
```
