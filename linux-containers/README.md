# Linux Containers

## Config

Hide legacy commands with DOCKER_HIDE_LEGACY_COMMANDS
- open shell in WSL distro, add to `~/.bashrc`:
  - `export DOCKER_HIDE_LEGACY_COMMANDS=1`
- windows side (ie for `powershell`)
  - add User Environment Variable
  - `DOCKER_HIDE_LEGACY_COMMANDS`
    - set to `1`

## Examples

```ps1

# NGINX
docker container run --rm -it -p 8080:80 nginx
open http://localhost:8080

# Jenkins
docker container run --rm -it -p 8080:8080 jenkins/jenkins
open http://localhost:8080

# TeamCity
docker container run -rm -it -p 8080:8111 jetbrains/teamcity-server
open http://localhost:8080

```

## .NET SDK

### Manually downloading

- [dot.net](https://dot.net)
- Pick a version:
  - At time of recording
    - `Current` = `.NET 5.0`
    - docker image `latest` tag points to `5.0`
    - `LTS` = `.NET Core 3.1`
    - `Preview`/`rc` = `.NET 6.0`
    - Work on `7.0` began in dev branches of repos

### Using a package manager (`winget`) to install the .NET SDK Preview

```shell
winget install -e --id Microsoft.dotnetPreview
dotnet --list-sdks # etc
winget uninstall --id Microsoft.dotnetPreview
```

Using `Docker` to run the .NET SDK:

```shell
# list SDKs
docker container run -rm -it mcr.microsoft.com/dotnet/sdk dotnet --list-sdks
docker container run -rm -it mcr.microsoft.com/dotnet/sdk:6.0 dotnet --list-sdks
```

```shell
# open containerized bash shell
docker container run -rm -it mcr.microsoft.com/dotnet/sdk:6.0
docker container run -rm -it mcr.microsoft.com/dotnet/sdk 

# use Ctrl+C to kill bash
# - stopping the process (and thus stopping the container)
# - after which `--rm` removes the container from the system
```

```shell
# pulling docker images
docker pull mcr.microsoft.com/dotnet/sdk:5.0
docker pull mcr.microsoft.com/dotnet/sdk:6.0
docker pull mcr.microsoft.com/dotnet/sdk:3.1
```
