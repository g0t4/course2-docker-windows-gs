# Windows Images

## Scenarios

- [PowerShell profile - completions](./pwsh/profile.ps1)
- [timezone examples](./time/)
- [webapi example](./webapi/)

## Switching to Windows Containers via the CLI

```ps1

# MSFT docs: https://docs.microsoft.com/en-us/documentation/
# Virtualization docs: https://docs.microsoft.com/en-us/virtualization
# - repo of virtualization docs (watch for changes)
#   - https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/live/virtualization/windowscontainers/quick-start/set-up-environment.md
#
# switch daemons via an undocumented CLI:
& $Env:ProgramFiles\Docker\Docker\DockerCli.exe -SwitchDaemon
#
# alternative - switch into dir and run command:
cd $Env:ProgramFiles\Docker\Docker
. \DockerCli. exe SwitchDaemon


```
