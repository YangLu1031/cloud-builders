#!/bin/bash

if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: $0 <builder-name> <source-image>"
  exit 1
fi

mkdir "$1"

echo '*
!Dockerfile'> "$1/.gcloudignore"

echo "FROM $2
ENTRYPOINT [\"$1\"]" > "$1/Dockerfile"

echo "# In this directory, run the following command to build this builder.
# gcloud builds submit --substitutions=_YYYYMMDD=\$(date +%Y%m%d)

steps:
- name: 'gcr.io/cloud-builders/docker'
  args:
  - 'build'
  - '--tag=us-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1'
  - '--tag=europe-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1'
  - '--tag=asia-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1'
  - '--tag=us-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:\${_YYYYMMDD}'
  - '--tag=europe-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:\${_YYYYMMDD}'
  - '--tag=asia-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:\${_YYYYMMDD}'
  - '.'
images:
- 'us-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:latest'
- 'europe-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:latest'
- 'asia-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:latest'
- 'us-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:\${_YYYYMMDD}'
- 'europe-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:\${_YYYYMMDD}'
- 'asia-docker.pkg.dev/$PROJECT_ID/cloud-builders/$1:\${_YYYYMMDD}'" > "$1/cloudbuild.yaml"

echo "# $1

This \`$1\` builder is based on the \`$2\` image supplied by TODO
at http://TODO

TODO additionally supports multiple tagged versions (TODO: as well as
additional tooling). For details, please visit
http://TODO

To migrate from \`gcr.io/cloud-builders/$1\` to this image, make the following
changes to your \`cloudbuild.yaml\`:

\`\`\`
- name: 'gcr.io/cloud-builders/$1'
+ name: '{region}-docker.pkg.dev/cloud-builders/cloud-builders/$1'
\`\`\`

where {region} is one of \`us\`, \`europe\`, or \`asia\`. Choose the closest region to
where your builds are executed.

## Example

Usage:

\`\`\`yaml
steps:
- name: 'us-docker.pkg.dev/cloud-builders/cloud-builders/$1'
  args: ['TODO']
\`\`\`

Using a tagged \`$1\` version:
\`\`\`yaml
steps:
- name: '$2:TODO'
  args: ['TODO']
  entrypoint: '$1'
\`\`\`" > "$1/README.md"

echo "\!$1
!$1/.gcloudignore
!$1/Dockerfile
!$1/cloudbuild.yaml" >> .gcloudignore
