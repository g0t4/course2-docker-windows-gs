# MySQL/MariaDB

## Common

```shell

# searches
winget search mysql
winget search mariadb
winget search --id oracle
winget search --id mariadb
# TODO visualizer on Win, or should shell in here too?

# just FYI, server components
# winget install -e --id MariaDB.Server
# winget install -e --id Oracle.MySQL

```

```bash

# TODO image/container commands
docker container run \
  -it \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=superseret \
  mysql 
# swap -it for -d to run in background immediately

```
