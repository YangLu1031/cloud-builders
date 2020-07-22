# dotnet

This `dotnet` builder is based on the `microsoft/dotnet:sdk` image supplied by
Microsoft at https://hub.docker.com/_/microsoft-dotnet-core.

Microsoft additionally supports multiple tagged versions as well as additional
dotnet tooling. For details, please visit
https://hub.docker.com/_/microsoft-dotnet-core.

To migrate from `gcr.io/cloud-builders/dotnet` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/dotnet'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/dotnet'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/dotnet'
```
