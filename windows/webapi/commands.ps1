
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

Get-Process *myapi*


## 3 - switch to process isolation 

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


## 4 - get process isolation to work

# update runtime-env: 
# FROM .../aspnet:6.0-nanoserver-ltsc2022

# optional: add tag to specify target architecture
docker build --tag myapi:nanoserver-ltsc2022 .

# run w/ process isolation successfully
docker container run --rm -i -t `
  --isolation process `
  -p 8080:80 `
  myapi:nanoserver-ltsc2022

## 5 - successfully observe isolation outside in!

Get-Process *myapi*
# awesome!