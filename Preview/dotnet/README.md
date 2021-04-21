# dotnet

This `dotnet` build step is based on the `mcr.microsoft.com/dotnet/sdk` image supplied by
Microsoft at https://hub.docker.com/_/microsoft-dotnet-sdk.

Microsoft additionally supports multiple tagged versions as well as additional
dotnet tooling. For details, please visit
https://hub.docker.com/_/microsoft-dotnet-sdk.

To migrate from `gcr.io/cloud-builders/dotnet` to this image, make the following
changes to your `cloudbuild.yaml`:

```
- name: 'gcr.io/cloud-builders/dotnet'
+ name: '{region}-docker.pkg.dev/cloud-builders/preview/dotnet'
```

where {region} is one of `us`, `europe`, or `asia`. Choose the closest region to
where your builds are executed.

## Example

Usage:

```yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/preview/dotnet'
```

## Example `cloudbuild.yaml`

This directory contains an [`example.yaml`](example.yaml) that uses `dotnet` to
build a simple test application. It can be executed via:
```
gcloud builds submit --config=example.yaml example
```
