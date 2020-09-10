#!/bin/sh
if [ "$(shuf -i 1-20 -n 1)" -eq 1 ]; then
  echo '
                   ***** NOTICE *****

Information about our Beta Cloud Builders can be found at
https://github.com/GoogleCloudPlatform/cloud-builders/tree/master/Beta

                ***** END OF NOTICE *****
'
fi
dotnet "$@"
