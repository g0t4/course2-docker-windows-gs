# OS images (base) and tags (base and downstream)

Some notes that might be helpful, not meant as a complete resource just some initial links to get started if you want to learn more.

## base OS links / considerations4

- [Docker Hub overview of Windows Base OS Images](https://hub.docker.com/_/microsoft-windows-base-os-images)
    - *refer to this page and its links for access to latest and recommended base images & tags*
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
    - Isolation impacts choices (read below)

## tags

- `latest` - not used on the Windows base OS images, due to need for compatibility between `container` and `container host` (albeit less restrictive than initial releases of Windows Conatiners)
- `ltsc` - [Long Term Support Channel](https://docs.microsoft.com/en-us/windows-server/get-started/servicing-channels-comparison#long-term-servicing-channel-ltsc)
- `sac` - [Semi Annual Channel](https://docs.microsoft.com/en-us/windows-server/get-started/semi-annual-channel-overview)
    - emphasis on transitioning to LTSC from SAC model so you'll see more and more ltsc tags instead of semi-annuals (`20H1`,`20H2`,etc) and instead `ltsc2019` or `2019ltsc` no doubt in some repos :)

## Windows Server releases

It helps to understand Windows Server the release candance and terminology as it comes through in image names.

- Current releases: https://docs.microsoft.com/en-us/windows-server/get-started/windows-server-release-info
- Wikipedia's [Windows releases table](https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions) is often concise and helpful
- [Base image servicing lifecycles](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/base-image-lifecycle)

## Windows OS Versions

- `docker image inspect {{image}}` 

```ps1
# inspect image (all details)
docker image inspect --format "{{json .}}"  mcr.microsoft.com/dotnet/sdk | jq -C
docker image inspect --format pretty  mcr.microsoft.com/dotnet/sdk | jq -C

# only retrieve image's OS Version:
docker image inspect --format "{{json .OsVersion}}"  mcr.microsoft.com/dotnet/sdk | jq -C

# os & os version
docker image inspect --format "{{json .OsVersion}}{{json .Os}}"  mcr.microsoft.com/dotnet/sdk | jq -C

```

- `Major.Minor.Build.Revision`
    - `Major` -
    - `Minor` -
    - `Build` -
    - `Revision` -
- `Version` - separte of but correlated to build numbers

## Isolation

- `isolation` - what dictates a container's runtime environment
    - with `linux` we're usally talking about `process isolation` via `namespaces` with resource constraints placed via `cgroups`, `capabilities`, security profiles (ie `seccomp`)
        - though there are plenty of efforts to provide alternative isolations for Linux containers (notably `VM isolation`)
    - `Windows Containers` have **2 primary types of `isolation`**
        - `hyper-v isolation` - aka `VM isolation` - a `lightweight`, `non-traditional VM` is used **per `container`** 
            - `container` runs inside this `VM`
            - provides the greatest degreee of security via `hardware isolation`.
        - `process isolation` 
            - same concept as linux's most prevalent isolation
            - the container is a process on the host that's highly isolated
                - imagine a wrapper around it (via the kernel) to hide other resources on the machine
                - container is given its own set of resources and that's all it sees (for the most part)
                - This is software isolation.
            - Uses an "upgraded" `Job Object` refererred to as a `Silo` 
    - `HostProcess isolation` is a new type in `Windows Server 2022` via `containerd`
        - [k8s article about HostProcess isolation](https://kubernetes.io/blog/2021/08/16/windows-hostprocess-containers/)
        - `Job Object` used instead of full `Silo` so this is the least type of isolation (very little)  - the purpose is to take advantage of images as a means of distributing and running containers (apps) with what would be traditional processes on the container host, hence `HostProcess isolation`!
            - Much like a `--privileged` container with `Docker` on `Linux` where the isolation is also "stripped away" giving the process access to host resources.
        - Purpose: primarily to run configuration processes on nodes utilizing images/containers without restricting access to host resources thus requiring another method of keeping the host updated.  
- `container host`/`host` - the machine that hosts the containers 
- `image`/`container image` - serves as a template for creating containers 
    - `image config` - the default configuration of parameters for the execution environment of a running container
        - what exedcutable runs in a given container?
            - See [docker container run docs](https://docs.docker.com/engine/reference/run/) for more
            - default entrypoint in Window base os images is `cmd.exe` or `PowerShell`
- `containers` - instances of images, like installed software, often running to provide a service but can be stopped and just be pending start


## Image compatibility

Compatibility is a somewhat rapidly shifting subject. I believe Microsoft is pushing to stabilize the Windows Kernel APIs so that it becomes much less of a concern, more like in the world of Linux containers. Linux has a notoriously stable ABI. And it seems that's where Microsoft is headed.
- Anyways, given the change, check MSFT docs for the latest as things have looseened up imperssively since I authored the first version of this course.
    - [Windows container version compatibility](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/version-compatibility)

- Defaults / specifying isolation to use when running a conatiner
    - `Windows 10` (`client SKUs`) defaults to `Hyper-V Isolation`
    - `Windows Server` defaults to `Process Isolation`
    - Specify the 

- Hyper-V Isolation
    - Given a VM is in use 
        - and each container has its own kernel
        - the `container host` OS version doesn't have to match `container`/`image` OS version
    - Limitations:
        - `container host` OS version >= `image` OS version
        - Temporarily (only until `Win 11 GA`) `Windows 10 v 21H1` container hosts can run `Windows Server 2022` images using `Hyper-V isolation` and special `preview tags` that will be removed
            - I think this hints at future support for forward compat in Hyper-V (and why not at least this?!) 
- Process Isolation
    - Given containerized processes run on the `container host`'s `kernel`
        - it's imperative for `images` to contain `libraries`/`services` that can rely on a **stable** set of `kernel APIs` (`syscalls`)
    - Limitations
        - Initially
            - `container host` OS version == `image` OS version
            - No backwards nor forwards compatibility
            - And strict equality, even the `revision` had to match!
        - Starting with `Windows 10 version 2004` (circa SAC in 2020 ~April) can run containers with `Process Isolation`!
        - Starting with `Windows 11` and `Windows Server 2022` the `Revision` doesn't need to match, can run images based on older OS versions
    - Forecasts
        - Long term I think the Windows Kernel APIs/syscalls will stabilize such that we have forward and backward compat with both Hyper-V and Process Isolation regardless if we use client vs server SKU.
        - I believe the emphasis on Containers and lightweight virtualization, specifically images for environment distirbuiton, have proven to be a motivator to stabilize the inner workings of the Windows Kernels and User Mode libraries/services, pushing MSFT in a good way that will be very valuable! And we'll see much more of it!
    - TODO changes since WS2016
