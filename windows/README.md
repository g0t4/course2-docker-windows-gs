# Windows Images

## Scenarios

- [PowerShell profile - completions](./pwsh/profile.ps1)
- [timezone examples](./time/)
- [webapi example](./webapi/)

## Switching to Windows Containers via the CLI

```ps1

# MSFT docs: https://docs.microsoft.com/en-us/documentation/
# - Virtualization docs: https://docs.microsoft.com/en-us/virtualization
& $Env:ProgramFiles\Docker\Docker\DockerCli.exe -SwitchDaemon
#
cd $Env:ProgramFiles\Docker\Docker
. \DockerCli. exe SwitchDaemon
#

```
