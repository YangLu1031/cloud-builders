# terraform

This `terraform` build step is based on the `hashicorp/terraform` image supplied
by Hashicorp at https://hub.docker.com/r/hashicorp/terraform/.

Hashicorp additionally supports multiple tagged versions of `terraform`,
including a `:full` version that provides additional tooling. For details,
please visit https://hub.docker.com/r/hashicorp/terraform/.

This image is available as
`{region}-docker.pkg.dev/cloud-builders/cloud-builders/terraform` where {region}
is one of `us`, `europe`, or `asia`. Choose the closest region to where your
builds are executed.

For additional information about Terraform, please visit
https://www.terraform.io/.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/terraform'
  args: ['show', '[OPTIONS]', '[PATH]']
```

Using a tagged `terraform` version:
```yaml
steps:
- name: 'hashicorp/terraform:0.12.29'
  args: ['show', '[OPTIONS]', '[PATH]']
  entrypoint: 'terraform'
```
