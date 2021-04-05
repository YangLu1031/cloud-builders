#!/bin/bash -reE
set -o pipefail

if [[ -z "$1" ]]; then
  echo "Usage: $0 {buildID}"
  exit 1
fi

exitvalue=1
set -u

while true; do
  status=$(gcloud builds describe $1 --format='value(status)')
  case "$status" in
    QUEUED|WORKING)
      echo "Build $1 is still ${status}; waiting..."
      sleep 5
      ;;
    SUCCESS)
      exitvalue=0
      break
      ;;
    *)
      break
  esac
done
echo "Build $1: ${status}."
exit $exitvalue
