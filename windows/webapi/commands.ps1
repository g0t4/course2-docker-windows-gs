
## 1 - build and run example

# build
docker build --tag myapi .

# run
docker container run --rm -it `
  -p 8080:80 `
  myapi

# open or curl:
#   http://localhost:8080
#   http://localhost:8080/weatherforecast


## 2 - observing isolation outsie in

# try to find dotnet process (w/ myapi running)
get-process *dotnet* 
  # even if run as admin, nope 
  # use procexp too (if desired)
  # :(

# show that it's hyper-v isolation
# ** hcsdiag requires run as admin (wt)
hcsdiag # prints help
  hcsdiag list # show container
  hcsdiag list -raw | jq -C # json
  # FYI if WSL running you'll see it too! 
    wsl # open WSL shell 
    hcsdiag list # (w/ or w/o -raw | jq -C) # show WSL now!
    # WSL is going to be off if you aren't using it! (win containers + pwsh)
  docker container ps --no-trunc # show matching IDs!
    # time permit look at path on disk!
Get-ComputeProcess # alternative 
  # shows Isolation & Type split out

## 3 - switch to process isolation 

# stop & rm the existing container
Ctrl+C 
  # or docker stop CID
  # ensure it is removed (else port conflicts and more factors to juggle)
hcsdiag list  
  Get-ComputeProcess # alternative 
  # notice Win Container is gone! 
  # hyper-v container tmpl lingers
    # run container again (hyperv isolation)
    # hcsdiag list
      # hcsdiag list -raw | jq -C
      # notice hyper-v container template reused! (hence lingers)

# hyperv isolation (default --isolation)
docker container run --rm -i -t `
  --isolation hyperv `
  -p 8080:80 `
  myapi

# process isolation
docker container run --rm -i -t `
  --isolation process `
  -p 8080:80 `
  myapi
# Fails (at least at time of recording, likely a fix arriving soonish is my guess)
# docker: Error response from daemon: container aa5999950631f2fcea8603238b616dc6784bbb9edbcaf18aa20113fdcaf9a672 encountered an error during hcsshim::System::Start: failure in a Windows system call: The container operating system does not match the host operating system. (0xc0370101).
  # this is by demo design!
  # don't fret if can't replicate problem, that means a fix was put into place
    # regardless if fixable, it is a good idea to target the architecture you will run under so as not to have surprises like this at runtime! 
    # long term MSFT will stabilize ABI (is my guess and they already hinted about that)
      # ABI slides here

## 4 - get process isolation to work

# update runtime-env: 
# FROM .../aspnet:6.0-nanoserver-ltsc2022

# optional: add tag to specify target architecture
docker build --tag myapi:nanoserver-ltsc2022 .

docker image ls # separate images now
# that's the value of specificity in tag
# now users know exactly what they're getting 
# and builds are more reproducible
  # at least stable in terms of the ABI 
    # revision might still vary between builds
      # but not breaking changes (per MSFT)
# point out no new intermediate build b/c for the build-env we still leave the tag at 6.0 and it runs hyper-v containers so the cache will still be hit for the build-env! 
  # big value prop!
  # FYI, you can specify isolation on a build

# run w/ process isolation successfully
docker container run --rm -i -t `
  --isolation process `
  -p 8080:80 `
  myapi:nanoserver-ltsc2022

curl localhost:8080/weatherforecast # w00t!

## 5 - successfully observe isolation outside in!

get-process *dotnet*
  get-process *dotnet* | fl *
    # run as admin
    # run as not admin 
    # you won't see myapi if not admin!
# awesome! (some degree of isolating non-privileged processes on host too)

# now! more isolation observation!
  Get-ComputeProcess 
  # notice
    # Type              : Container
    # Isolation         : Process
    # IsTemplate        : False
      # template not referenced (not a hypyer-v container!)

  hcsdiag list -raw | jq -C 
    # "SystemType": "Container",
    # "RuntimeOsType": "Windows",  
      # Windows & Container!
    # "Owner": "docker",
    # "ObRoot": "\\\\.\\Silos\\1720"
      # Silo eh!

## 5b - conclude with slide of container types in Windows!