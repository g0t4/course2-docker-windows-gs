# enable script debugging
# - set level of tracing to 1 
# - docs: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/set-psdebug?view=powershell-7.2
Set-PSDebug -Trace 1

# first check host timezone (before all commands)
hostname; (get-timezone).DisplayName; (get-date).ToShortTimeString();

# build all images
docker build --tag no-set-tz `
  --file Dockerfile.no-set-tz .

docker build --tag set-tz:nanoserver `
  --file Dockerfile.set-tz-nanoserver .

docker build --tag set-tz:servercore `
  --file Dockerfile.set-tz-servercore .

# checks host after building images (changing timezones inside containers)
hostname; (get-timezone).DisplayName; (get-date).ToShortTimeString();

# run containers based on successful image builds
# - see what timezone is baked in
docker container run --rm -it no-set-tz
docker container run --rm -it set-tz:servercore

# check host again just to confirm no changes to the host timezone
hostname; (get-timezone).DisplayName; (get-date).ToShortTimeString();

# disable script debugging
Set-PSDebug -Off