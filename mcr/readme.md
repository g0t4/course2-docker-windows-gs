
## dockerCli.exe

My findings (mostly a long list of thoughts)

- Location `$Env:ProgramFiles\Docker\Docker\DockerCli.exe`
- To inspect the tool yourself, install `dotPeek` or another `.NET decompiler`
  - Open `DockerCli.exe`
  - search for strings (Ctrl+Alt+T) - type in `SwitchDaemon`
  - or, jump to `Docker.Cli.BackendCli`'s 
    - method `private void Run(Docker.Core.Cli.Flags flags)`
- What I've tested
  - The DDfW frontend must be running (ie **tray icon is visible** but doesn't have to be in operational state, ie with solid containers) for this to work as this seems to only send control messages to the backend(s).
    - These all seem to be about controlling the `backend`, not the `frontend`
    - These appear to work the same as much of what I've used in the tray icon context menu for DDfW frontend. Some of this I've cursorily matched DockerCLI switch code to the menu code handlers and they seem identical in some cases.
    - Hence code is in classes like `BackendCli`!
  - Flag notes:
    - Commands are case sensitive (confirmed in code used in `Flags.cs` in decompiled code, also in usage - case matters)
    - `-SwitchDaemon` - successfully toggles (ostensibly, it's leaving each backend running, it toggles which one Docker Desktop presents - Dashboard, context tray menu, etc)
      - Once both backends have started once, these are so fast the icons barely or never animate in the tray (in my testing)
      - `-SwitchLinuxEngine` - from windows to linux
      - `-SwitchWindowsEngine` - from linux to windows
    - `-Shutdown` - does seem to stop the backend(s)
    - Prefix with odd `"secret"` flag as marked in code
      - `--testftw!928374kasljf039 -Stop` (tray icon, the front end, will remain open but indicate backend is stopped--no containers on icon)
      - `--testftw!928374kasljf039 -Start` (tray icon, the front end, will indicate backend started--containers animate in and show on icon)
    - I haven't looked into code behind these yet but they may be about starting a backend without switching to it and if so could very well work
      - `-StartWSL2Engine`
      - `-StartWindowsEngine`
      - `-StartHyperVEngine`
    - Not too helpful:
      - `--testftw!928374kasljf039 -Restart` (or it works so fast I don't notice, need to look at code again)
      - `-h`/`--help`/`-Help` - just print that you can use these help flags :) 
  - Untested:
    - `--testftw!928374kasljf039` + `-Mount` or `-Unmount` or `-AuditSecurity`
  - Caution/considerations
    - Some say it is internal only, not a public facing tool and yet it ships with and is sparsely mentioned in MSFT docs
      - https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/10599d5bbabc02e3c0bf2b1cfd627c4ab444cd66/virtualization/windowscontainers/quick-start/set-up-environment.md?plain=1#L114-L116
    - There are several issues where a mention is made that `DockerCli` is internal only and not documented (not true as it does exist in some docs) but relatively speaking it's nearly undocumented.
      - https://github.com/docker/for-win/issues/11751#issuecomment-886562522
      - And some mentions that it may be removed but no action on that and instead I've seen fixes made to get features working again when broken
  - **No matter what we need a way to flip the container mode outside of the GUI IMO**
    - **And ASAP we need hybrid** side by side mode **and I see that coming**
      - in fact it often works for me when I switch daemons of late the other remains available and to control too (ie WSL to control linux daemon even when Windows Containers mode is "selected" by Docker Desktop front end and I see several mentions that this is in the works or will be soon... the evidence alone to me is the somewhat vestigial traces of this in `docker context ls`)

## Windows Containers feedback

- [Windows Container GitHub community.](https://github.com/microsoft/Windows-Containers/issues)

## Links

- Great guide to running a Windows Container without docker, using hcsshim's commands like `runhcs.exe` and `wclayer.exe` [Hands on Windows Container Internals](https://poweruser.blog/hands-on-windows-container-internals-c9782d0115ff)
- [Windows Server -> Containers blog](https://techcommunity.microsoft.com/t5/containers/bg-p/Containers) for changs, news, etc
