####### 1 - build/run/test myapi works

# build
docker build --tag myapi .

# run
docker container run --rm -it `
  -p 8080:80 `
  myapi

# test myapi:
# should get 404:
curl http://localhost:8080
# should get api response with random weather data:
curl http://localhost:8080/weatherforecast




######### 2 - observing isolation "outside in"

# from the container host:
# - try to find the dotnet process running myapi inside the container: 
get-process *dotnet* 
  # no results, why?

# show that it's hyper-v isolation
# ** hcsdiag requires run as admin (wt)
hcsdiag # prints help
  hcsdiag list # query HCS and list Containers and VMs
  hcsdiag list -raw | jq -C # json structure and further data returned
  
# (OPTIONAL): If WSL is running you'll see it too! 
  # WSL is going to be off if you aren't using it! (ie: win containers + pwsh)
  # ensure WSL shell is open
  wsl
  # new tab, run: 
  hcsdiag list 
    # WSL returned!

# Container ID will match IDs from hcsdiag
docker container ps --no-trunc
  # compare to hcsdiag list output

# alternative (to hcsdiag list)
Get-ComputeProcess  
  # shows Isolation & Type split out


####### 3 - switch to process isolation 

# (OPTIONAL) stop & rm the existing container
Ctrl+C # run this in pane that has the myapi server running
  # or docker stop CID
  # ensure it is removed (else port conflicts and more factors to juggle)
hcsdiag list  
  Get-ComputeProcess # alternative 
  # notice Win Container is gone! 

# for reference: 
  # setting explicit hyperv isolation (this is the default on client SKUS of 10/11)
docker container run --rm -i -t `
  --isolation hyperv `
  -p 8080:80 `
  myapi

# request process isolation instead
docker container run --rm -i -t `
  --isolation process `
  -p 8081:80 `
  myapi
  # notice port is 8081 now
  # Fails (at least at time of recording, likely a fix arriving soonish is my guess)
    # see course for explanation 
    # docker: Error response from daemon: container aa5999950631f2fcea8603238b616dc6784bbb9edbcaf18aa20113fdcaf9a672 encountered an error during hcsshim::System::Start: failure in a Windows system call: The container operating system does not match the host operating system. (0xc0370101).
  # don't fret if can't replicate problem, that means a fix might have been put into place when it comes to docker selection when using a multi-arch image (manifest list)
    # regardless if fixed, it is a good idea to target the architecture you will run under so as not to have surprises like this at runtime! 
  # long term MSFT will stabilize kernel mode / user mode ABI 
    # they have already stabilized ABI across revisions (patches)
    # and going forward with WS2022/Win11 we have stability across build numbers (this is a preview feature so I'm sure some thinks need worked out and the extent of this stability - only time will tell us)
    # my guess is they will continue to stabilize it so it's not much of a thought for you as an end user because this is a major pain point
    
## 4 - get process isolation to work

# look at all platforms that are supported for the 6.0 multi-arch tag:
  docker manifest inspect mcr.microsoft.com/dotnet/aspnet:6.0 | jq -C
# pick a platform specific tag from the aspnet / dotnet Docker Hub repos - see their tag listings to guide your decision 
# https://hub.docker.com/_/microsoft-dotnet-aspnet/
# https://hub.docker.com/_/microsoft-dotnet
#
# for the demo in the course recording:
  # want Nano Server base image
  # want .NET built on top (and specifically aspnet runtime optimized image)
    # so, tag of 6.0-nanoserver-ltsc2022
  # for fun query the manifest of this platform specific tag:
  docker manifest inspect -v `
    mcr.microsoft.com/dotnet/aspnet:6.0-nanoserver-ltsc2022 `
    | jq -C
    # note -v verbose flag adds platform details when an image is not multi-arch (multi-platform)
  # ** Note: both Server Core and Nano Server images are avail
    # if you want / need Server Core that's available too:
      # 6.0-servercore-ltsc2022
    docker manifest inspect -v mcr.microsoft.com/dotnet/aspnet:6.0-windowsservercore-ltsc2022 | jq -C
# for fun, look at base images (not with .NET layers):
  docker manifest inspect mcr.microsoft.com/windows/nanoserver:ltsc2022 | jq -C
  docker manifest inspect mcr.microsoft.com/windows/servercore:ltsc2022 | jq -C
  # strange - these are not multi-arch but they are returning manifest lists of the single supported platform... 

# NOW, update tag used in runtime-env: 
# FROM .../aspnet:6.0-nanoserver-ltsc2022

# rebuild image:
  # optional: add tag to specify target architecture
docker build --tag myapi:nanoserver-ltsc2022 .

docker image ls # separate images now
# that's the value of specificity in tag
# - users know exactly what they're getting 
# Notice, there's no new intermediate build b/c for the build-env we still leave the tag at 6.0 and it runs w/ hyper-v isolation to build the app which is fine, we only care about runtime using process isolation for now
  # so the cache will still be hit for the build-env! 
  # big value prop!
  # FYI, you can specify isolation on a build
    # perhaps that is a way to speed up your builds

# run w/ process isolation successfully
docker container run --rm -i -t `
  --isolation process `
  -p 8081:80 `
  myapi:nanoserver-ltsc2022

curl localhost:8081/weatherforecast # w00t!

## 5 - successfully observe isolation outside in!

# run as admin
get-process *dotnet*
  get-process *dotnet* | fl *
    # look at CommandLine property
# (repeat get-process calls - no Running as Admin)
  # most details in fl * will be missing if not an Admin 
# awesome! (some degree of isolating non-privileged processes on host too)

# now! more isolation observation!
  Get-ComputeProcess 
  # notice
    # Type              : Container
    # Isolation         : Process

  hcsdiag list -raw | jq -C 
    # "SystemType": "Container",
    # "RuntimeOsType": "Windows",  
      # Windows & Container!
    # "Owner": "docker",
    # "ObRoot": "\\\\.\\Silos\\1720"
      # Silo eh!
      # dig into silos to learn more about process isolation in Windows containers