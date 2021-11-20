# Tools

A few of the tools covered throughout the course. Especially some setup / installs from first module.

## WSL2 pre-requisites

If you want to install WSL2 before DDfW, use the following commands. Otherwise, DDfW will enable the appropriate features but will still (currently) depend on Windows Update for the latest kernel.

```powershell

# Ensure setting to get other windows products with Windows Update is enabled (Settings -> Windows Update -> Advanced)
# Run Windows Update until no new updates available

wsl --install
# note: wsl --instal will handle part of what Windows Update would handle for you (ie the latest kernel)

# check wsl is operational:
wsl --status
# address any issues
# ensure wsl version default is 2, else:
wsl --set-default-version 2

```

## App Installs

```powershell

# Docker Desktop for Windows
winget install -e --id Docker.DockerDesktop

# Windows Terminal (stable)
# https://devblogs.microsoft.com/commandline/
winget install -e --id Microsoft.WindowsTerminal
winget install -e --id Microsoft.WindowsTerminalPreview

# PowerShell Core
winget install -e --id Microsoft.PowerShell
winget install -e --id Microsoft.PowerShell.Preview

# Visual Studio Code
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Microsoft.VisualStudioCode.Insiders
# or, Visual Studio
winget install -e --id Microsoft.VisualStudio.2022.Community-Preview

# Browser
winget install -e --id BraveSoftware.BraveBrowser

# bat & jq (windows side)
choco install -y jq bat

```
