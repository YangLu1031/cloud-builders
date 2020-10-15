# kubectl

This `kubectl` build step is based on the
`gcr.io/google.com/cloudsdktool/cloud-sdk` image supplied by the Google Cloud
SDK team.  Please visit https://github.com/GoogleCloudPlatform/cloud-sdk-docker
for details.

The Cloud SDK team additionally supports multiple tagged versions of `kubectl`
across multiple platforms. For details, please visit
https://github.com/GoogleCloudPlatform/cloud-sdk-docker.

To migrate from `gcr.io/cloud-builders/kubectl` to this image, make the following
changes to your `cloudbuild.yaml`:

```diff
- name: 'gcr.io/cloud-builders/kubectl'
+ name: '{region}-docker.pkg.dev/gcb-release/cloud-builders/kubectl'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Usage

For most uses, `kubectl` will need to be configured to point to a specific GKE
cluster. You can configure the cluster by setting environment variables.

    # Set region for regional GKE clusters or Zone for Zonal clusters
    CLOUDSDK_COMPUTE_REGION=<your cluster's region>
    # or
    CLOUDSDK_COMPUTE_ZONE=<your cluster's zone>

    # Name of GKE cluster
    CLOUDSDK_CONTAINER_CLUSTER=<your cluster's name>

**When using Google Cloud Build, it is likely easiest to set these environment
variables on the build itself rather than on each individual step that uses
`kubectl`.**

If your GKE cluster is in a different project than the build itself, also set:
```
CLOUDSDK_CORE_PROJECT=<your GKE cluster project>
```

## Example

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/kubectl'
  args: ['get', 'pods']
options:
  env:
  - 'CLOUDSDK_COMPUTE_REGION=us-central1'
  - 'CLOUDSDK_CORE_PROJECT=my-gke-cluster'
```

Using a tagged `kubectl` version:
```yaml
steps:
- name: 'gcr.io/google.com/cloudsdktool/cloud-sdk:300.0.0'
  args: ['get', 'pods']
  entrypoint: 'kubectl'
options:
  env:
  - 'CLOUDSDK_COMPUTE_REGION=us-central1'
  - 'CLOUDSDK_CORE_PROJECT=my-gke-cluster'
```
