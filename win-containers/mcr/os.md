# OS images (base) and tags (base and downstream)

Some notes that might be helpful, not meant as a complete resource just some initial links to get started if you want to learn more.

## base OS links / considerations4

- [Docker Hub overview of Windows Base OS Images](https://hub.docker.com/_/microsoft-windows-base-os-images)
- Currently 4 base OS images:
    - 2 have been around since inception of Windows Containers
        - [windows/nanoserver](https://hub.docker.com/_/microsoft-windows-nanoserver)
            - designed for modern, greenfield apps
            - specifically .NET Core (now .NET 5/6)
        - [windows/servercore](https://hub.docker.com/_/microsoft-windows-servercore)
    - 2 are newer (seems only 1 will emerge)
        - Both are about the same size, `windows` is a bit bigger
        - [windows/server](https://hub.docker.com/_/microsoft-windows-server)
        - [windows](https://hub.docker.com/_/microsoft-windows)
            - `windows/server` is replacing this w/ approximately the same set of APIs
- Picking a base image
    - Consider size
    - Evaluate images: nanoserver (smallest) -> servercore (middle) -> server (biggest)
        - Most apps will run with `windows/server`
        - Many existing apps (ie .NET Framework) will also run with `windows/servercore`
        - Only modern apps will work with `windows/nanoserver`
    - Watch latest docs and announcemnets for changes that inevitably come

## container image version compat

- [Windows container version compatibility](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/version-compatibility)

## common terms / abbreviations 

- `isolation` type or mode - container's runtime environment, with linux we're usally talking about `process isolation` via `namespaces` with resource constraints placed via `cgroups`, `capabilities`, security profiles (ie `seccomp`)
- `container host`/`host` - the machine that hosts the containers 
- `image`/`container image` - serves as a template for creating containers 
    - `image config` - the default configuration of parameters for the execution environment of a running container
        - what executable runs in a given container?
            - See [docker container run docs](https://docs.docker.com/engine/reference/run/) for more
            - default entrypoint in Window base os images is `cmd.exe` or `PowerShell`

- `containers` - instances of images, like installed software, often running to provide a service but can be stopped and just be pending start

- `ltsc` - [Long Term Support Channel](https://docs.microsoft.com/en-us/windows-server/get-started/servicing-channels-comparison#long-term-servicing-channel-ltsc)
- `sac` - [Semi Annual Channel](https://docs.microsoft.com/en-us/windows-server/get-started/semi-annual-channel-overview)
    - emphasis on transitioning to LTSC from SAC model so you'll see more and more ltsc tags instead of semi-annuals (`20H1`,`20H2`,etc) and instead `ltsc2019` or `2019ltsc` no doubt in some repos :)

## Windows Server releases

It helps to understand Windows Server the release candance and terminology as it comes through in image names.

- Current releases: https://docs.microsoft.com/en-us/windows-server/get-started/windows-server-release-info
- Wikipedia's [Windows releases table](https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions) is often concise and helpful
- [Base image servicing lifecycles](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/base-image-lifecycle)
### Windows OS Version

- `Major.Minor.Build.Revision`
    - `Major` -
    - `Minor` -
    - `Build` -
    - `Revision` -
- `Version` - separte of but correlated to build numbers
