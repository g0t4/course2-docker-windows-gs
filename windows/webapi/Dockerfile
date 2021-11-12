# escape=`
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

WORKDIR /app/src

# generate sample code, easy way to test out latest template
RUN dotnet new webapi `
  --name myapi --no-restore --output /app/src/ `
  --no-https 

RUN dotnet restore

RUN dotnet publish `
  --configuration Release --no-restore  --no-self-contained `
  --output /app/pub/



FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime-env

WORKDIR /app

COPY --from=build-env /app/pub /app

ENTRYPOINT ["dotnet","/app/myapi.dll"]







## Links / notes
#
# - multi-stage build image choices
#   - the two I use are explained nicely here:
#   - https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/docker/building-net-docker-images?view=aspnetcore-6.0#aspnet-core-docker-images
#
# dotnet help
# - https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish
# - https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-new 
#