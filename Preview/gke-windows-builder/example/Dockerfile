# escape=`
# The WINDOWS_VERSION value is filled by gke-windows-builder on run time.
# https://github.com/GoogleCloudPlatform/kubernetes-engine-windows-tools/blob/6bb24f152dd7a238d62f0f86ac819f22229ff807/gke-windows-builder/builder/main.go#L312
ARG WINDOWS_VERSION
FROM mcr.microsoft.com/windows/servercore:${WINDOWS_VERSION}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-Content C:\greeting.txt \"Hello container\"

CMD Get-Content C:\greeting.txt
