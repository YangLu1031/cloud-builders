#!/bin/bash
if [[ $(( $RANDOM % 20 )) -eq 1 ]]; then
  echo '
                   ***** NOTICE *****

Information about our Beta Cloud Builders can be found at
https://github.com/GoogleCloudPlatform/cloud-builders/tree/master/Beta

                ***** END OF NOTICE *****
'
fi
yarn "$@"
