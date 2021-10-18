# `--format` output across commands (i.e. `ls`, `inspect`)

## Why?

- Often output excludes fields available (ie `ls` commands)
- Avoid wrapping excessive data when running `docker container ls` etc (... windows container image names especially!)
- You can override defaults to see what you care about
- These are frustrating at times! But worth learning!

## JSON is your friend

- Use `json` output to see full list of what's available
    - And how to refer to it in your custom format strings 
    - `Fields` are case sensitive 
    - and sometimes named different than in `table` formatted headers
- `jq` is your friend (pipe to it)

## References

- [Format command and log output](https://docs.docker.com/config/formatting/)
    - basic examples, an introduction to formatters
- Refer to command reference docs for fields available, casing, and usage too
    - [`docker ps` formatting section](https://docs.docker.com/engine/reference/commandline/ps/#formatting) 
        - NOT `docker container ps` reference!

## Override default formatting

- Store your preferred formats in `~/.docker/config.json` (docker client config)
    - i.e. `psFormat` 
- Or, consider a `shell` `alias`/`function`
- Or a `snippet` that expands via any snippet tool
