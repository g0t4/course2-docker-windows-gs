# MongoDB

- <https://www.mongodb.com>

```powershell

# general search
winget search --id mongodb

# compass
# https://www.mongodb.com/products/compass
winget install -e --id MongoDB.Compass.Community
# or, full:
winget install -e --id MongoDB.Compass

# mongo shell - use a docker container!
# winget install -e --id MongoDB.Shell
# again, when possible use image
# winget install -e --id MongoDB.DatabaseTools

# WIP - if not already, use this as an example to explore image config for entrypoint and CMD to see how to open bash shell if desired, or just open mongo shell :) 
docker run --rm -it mongo # TODO finish as desired later
# good networking exercise too!
# and I smell docker-compose too


```
