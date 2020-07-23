#!/bin/bash
# This script makes it easy to add new builders!
# 1. Run `./add-builder.sh <builder-name> <source-image>`
# 2. Examine the local changes via `git status` and `git diff`.
# 3. Edit the <builder-name>/README.md file.
# 4. `git commit -a`

if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: $0 <builder-name> <source-image>"
  exit 1
fi

mkdir "$1"

echo '*
!Dockerfile'> "$1/.gcloudignore"

echo "FROM $2
ENTRYPOINT [\"$1\"]" > "$1/Dockerfile"

echo "# $1

This \`$1\` build step is based on the \`$2\` image supplied by TODO
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
