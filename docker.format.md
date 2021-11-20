# `--format` output across commands (i.e. `ls`, `inspect`)

## Why?

- Often output excludes fields available (ie `ls` commands)
- Avoid wrapping excessive data when running `docker container ls` etc (... windows container image names especially!)
- These `templates` are frustrating at times! But worth learning!

## JSON is your friend

- Use `json` output to see full list of what's available
  - `--format "{{json .}}"`
  - And how to refer to fields in your custom format strings even if not targeting `json` output
  - `Fields` are case sensitive
  - and sometimes named different than in `table` formatted headers
- `jq` is your friend (pipe to it)

## References

- [Format command and log output](https://docs.docker.com/config/formatting/)
  - basic examples, an introduction to formatters
- Also, refer to individual command reference docs
  - for fields available, casing, and usage
  - sometimes a command is both a top-level command and nested under a management command, you might find docs in either reference docs
    - i.e. [`docker ps` formatting section](https://docs.docker.com/engine/reference/commandline/ps/#formatting)
      - NOT `docker container ps` reference!

## Override default formatting

- Store your preferred formats in `~/.docker/config.json` (docker client config)
  - i.e. `psFormat`
- Or, consider a `shell` `alias`/`function`
- Or a `snippet` that expands via any snippet tool
