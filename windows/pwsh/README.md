# PowerShell profile (completion features)

- docker CLI COMPLETIONS
  - [docker/cli repo - powershell completions](https://github.com/docker/cli/tree/master/contrib/completion/powershell)
    - links to [DockerCompletion package](https://github.com/matt9ucci/DockerCompletion)
    - TLDR: `Install-Package DockerCompletions`
- Now, setup a profile to load this and other options by default every time you open a powershell session
  - `code $PROFILE`
  - use provided contents of [profile.ps1](./profile.ps1)
