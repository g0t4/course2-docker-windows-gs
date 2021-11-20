# windows containers

## Examples

```ps1

# opening Windows Terminal
wt
# to run as admin:
# - Win+R
# - type `wt` into run box
# - Ctrl+Shift+Enter
# - click yes

# enable Windows features needed for Windows containers
Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All

# switch to windows containers (with system tray icon for DDfW)
# validate switched ok by checking for client and server response via version info:
docker version

# Microsoft's publisher page on Docker Hub
#   https://hub.docker.com/publishers/microsoftowner

# IIS image (like nginx or httpd before)
# https://hub.docker.com/_/microsoft-windows-servercore-iis
docker pull mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022

# MCR (microsoft container registry)
# https://github.com/microsoft/ContainerRegistry
#
# mcr API:
# - catalog of repositories:
#   https://mcr.microsoft.com/v2/_catalog
# - query tags for a given repo
#   https://mcr.microsoft.com/v2/{repo}/tags/list
#   i.e. https://mcr.microsoft.com/v2/dotnet/sdk/tags/list
#

# name changes for dotnet image repos
# https://github.com/dotnet/dotnet-docker/issues/2375

# run IIS
# note line continuation with ` backtick in powershell
docker container run -d `
  --publish 8080:80 `
  --name iis `
  mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022

# stop a running container
docker container stop iis

# list containers
docker container ls
docker container ps

# list all containers (including stopped)
docker container ls -a
docker container ps -a

# start a stopped container
docker container start iis

# start a 2nd IIS container!
docker container run -d `
  --publish 8081:80 `
  --name iis2 `
  mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022

# list containers in json format
docker container ls --format "{{json .}}"
# pipe to jq inside wsl! (running from powershell)
docker container ls --format "{{json .}}" | wsl jq
# ensure no truncation of output (--no-trunc)
docker container ls --format "{{json .}}" --no-trunc | wsl jq
# custom table formats (various fields as columns)
docker container ls --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
docker container ls --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.State}}"
```

```json
// change default format in ~\.docker\config.json under psFormat
// https://docs.docker.com/engine/reference/commandline/cli/#docker-cli-configuration-file-configjson-properties
// https://docs.docker.com/engine/reference/commandline/ps/#formatting
// https://docs.docker.com/config/formatting/
{
  //...
  "psFormat": "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
}
```

See more about [formatting here](./docker.format.md)

```ps1

# after setting a new deafult in ~\.docker\config.json, show old default with:
docker container ls --format table

# remove a stopped container
docker container rm iis

# stop and remove a container
docker container rm -f iis2

# system level resources utilized
docker system df

```
