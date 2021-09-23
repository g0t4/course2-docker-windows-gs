# PostgreSQL

- <https://www.postgresql.org/>

```powershell

# general search
winget search --id PostgreSQL

# GUI (pgAdmin ~= SSMS)
winget install -e --id PostgreSQL.pgAdmin

# FYI, this is server (database) component - we'll use containers
# think about what all is happening as you install so many diff db engines into your env
  # how do you ensure they are not running when not needed!
  # file conflicts?
  # perf impacts?
# winget show --id PostgreSQL.PostgreSQL

# TODO image/container commands
```
