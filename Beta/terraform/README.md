# terraform

This `terraform` build step is based on the `hashicorp/terraform` image supplied
by Hashicorp at https://hub.docker.com/r/hashicorp/terraform/.

Hashicorp additionally supports multiple tagged versions of `terraform`,
including a `:full` version that provides additional tooling. For details,
please visit https://hub.docker.com/r/hashicorp/terraform/.

This image is available as
`{region}-docker.pkg.dev/gcb-release/cloud-builders/terraform` where {region}
is one of `us`, `europe`, or `asia`. Choose the closest region to where your
builds are executed.

For additional information about Terraform, please visit
https://www.terraform.io/.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/gcb-release/cloud-builders/terraform'
  args: ['show', '[OPTIONS]', '[PATH]']
```

Using a tagged `terraform` version:
```yaml
steps:
- name: 'hashicorp/terraform:0.12.29'
  args: ['show', '[OPTIONS]', '[PATH]']
  entrypoint: 'terraform'
```

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that configures
`terraform` to set up a single GCE VM.
It can be executed via:
```
gcloud builds submit --config=example.yaml example
```

To use `terraform` to actually deploy the VM

1. Edit the [example.tf](example/example.tf) file to specify the Google Cloud
   Project where you want to deploy the VM.
1. Grant your [Cloud Build Service
   Account](https://cloud.google.com/cloud-build/docs/cloud-build-service-account)
   the [Compute
   Admin](https://cloud.google.com/compute/docs/access/iam#compute.admin) role.
1. Add the following additional build steps to the
   [`example.yaml`](example.yaml):
   ```
   - name: 'us-docker.pkg.dev/$PROJECT_ID/cloud-builders/terraform'
     args: ['apply', '--auto-approve']
   - name: 'us-docker.pkg.dev/$PROJECT_ID/cloud-builders/terraform'
     args: ['show']
   ```
