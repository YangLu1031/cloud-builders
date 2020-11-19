#!/bin/bash
#
# This script generates cloudbuild.yaml for each builder.
# It's used by both the nightly build and the push-to-branch trigger to build
# all builders.

set -eEo pipefail

# Triggers execute from the root of the repository, so the following
# conditional enables this build config to work correctly both from the
# repository root and from within the `Beta` directory.
[[ -d Beta ]] && cd Beta

push="true"
if [[ -z "${REGISTRIES}" ]]; then
  REGISTRIES="just-build-no-push"
  push="false"
fi

if [[ -z "${TEMPLATE_NAME}" ]]; then
  TEMPLATE_NAME="cloudbuild.yaml"
fi

set -u

# First we create a cloudbuild.yaml that builds each Dockerfile into its
# appropriate image.
prevstep=''
template=''
declare -A pushimages
for dockerfile in */Dockerfile*; do
  # Given mvn/Dockerfile.appengine:
  #   $step       is `mvn`
  #   $dockerfile is `Dockerfile.appengine`
  #   $tag        is `appengine`
  step=$(dirname "${dockerfile}")
  dockerfile=$(basename "${dockerfile}")
  IFS=. read _ tag <<< "${dockerfile}"

  if [[ "${step}" != "${prevstep}" ]]; then
    template="${step}/${TEMPLATE_NAME}"
    pushimages["${step}"]=''

    # Start a new template.
    [[ -e "${template}" ]] && rm "${template}"
    echo "steps:" > "${template}"
  fi
  prevstep="${step}"
  images=''

  s1=''
  s2=':${_YYYYMMDD}' #_YYYYMMDD is a build-time substitution
  if [[ -n "${tag}" ]]; then
    s1=":${tag}"
    s2=":${tag}-\${_YYYYMMDD}"
  fi

  for r in ${REGISTRIES}; do
    images="${images} ${r}/${step}${s1}"
    images="${images} ${r}/${step}${s2}"
  done

  echo "- name: 'gcr.io/cloud-builders/docker'" >> "${template}"
  echo "  args:"                                >> "${template}"
  echo "  - 'build'"                            >> "${template}"
  echo "  - '-f'"                               >> "${template}"
  echo "  - '${dockerfile}'"                    >> "${template}"

  for image in ${images}; do
    echo "  - '--tag=${image}'" >> "${template}"
  done
  echo "  - '.'" >> "${template}"

  pushimages["${step}"]="${pushimages[${step}]} ${images}"
done

# Now finish all build configurations with images to push, timeouts, and tags.
for step in "${!pushimages[@]}"; do
  template="${step}/cloudbuild.yaml"
  echo "timeout: 1200s"  >> "${template}"
  echo "tags:"           >> "${template}"
  echo '- ${_YYYYMMDD}'  >> "${template}"
  echo '- ${_TRIGGER}'   >> "${template}"
  echo "- ${step}"       >> "${template}"
  if [[ "${push}" == "true" ]]; then
    echo "images:" >> "${template}"
    for image in ${pushimages["${step}"]}; do
      echo "- '${image}'" >> "${template}"
    done
  fi
done
