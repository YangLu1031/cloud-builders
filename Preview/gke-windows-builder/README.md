# gke-windows-builder

This `gke-windows-builder` build step is based on `us-docker.pkg.dev/gke-windows-tools/docker-repo/gke-windows-builder` image supplied by GKE Windows team at [GoogleCloudPlatform/kubernetes-engine-windows-tools](https://github.com/GoogleCloudPlatform/kubernetes-engine-windows-tools).

This image is available as {region}-docker.pkg.dev/cloud-builders/preview/gke-windows-builder where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to where your builds are executed.

If you have any questions or issues, please [create an issue in the GoogleCloudPlatform/kubernetes-engine-windows-tools repository](https://github.com/GoogleCloudPlatform/kubernetes-engine-windows-tools/issues).

# Usage
## One-time steps in your GCP project
```
export PROJECT=$(gcloud info --format='value(config.project)')
export MEMBER=$(gcloud projects describe $PROJECT --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com

# Enable the Cloud Build and Compute APIs on your project:
gcloud services enable cloudbuild.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable artifactregistry.googleapis.com

# Assign roles. These roles are required for the builder to create the Windows
# Server VMs, to copy the workspace to a Cloud Storage bucket, to configure the
# networks to build the Docker image and to push resulting image to artifact registry:
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:$MEMBER --role='roles/compute.instanceAdmin'
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:$MEMBER --role='roles/iam.serviceAccountUser'
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:$MEMBER --role='roles/compute.networkViewer'
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:$MEMBER --role='roles/storage.admin'
gcloud projects add-iam-policy-binding $PROJECT --member=serviceAccount:$MEMBER --role='roles/artifactregistry.writer'

# Add a firewall rule named allow-winrm-ingress to allow WinRM to connect to
# Windows Server VMs to run a Docker build:
gcloud compute firewall-rules create allow-winrm-ingress --allow=tcp:5986 --direction=INGRESS
```

## Sample cloudbuild.yaml
```yaml
timeout: 3600s
steps:
  - name: 'us-docker.pkg.dev/cloud-builders/preview/gke-windows-builder'
    args:
    - --container-image-name
    - 'us-docker.pkg.dev/$PROJECT_ID/docker-repo/windows-multiarch-container-demo:cloudbuild'
```
For more info on provided args, please go to https://cloud.google.com/kubernetes-engine/docs/tutorials/building-windows-multi-arch-images#advanced_gke-windows-builder_usage.

# Example
This directory contains an `example` folder that uses `gke-windows-builder` to create a hello-world multi-arch Windows Server container. It can be executed via:
```
gcloud builds submit --config=example/cloudbuild.yaml example/
```
