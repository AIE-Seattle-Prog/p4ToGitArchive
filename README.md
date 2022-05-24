# P4 to Git Archive

This contains a set of scripts that download P4 depots and push them onto GitHub
as a new repository.

```text
depot1
depot2
depot3
```

These scripts are "proof-of-concept" status and should not be considered fully
vetted for production purposes at this time.

> :clap: Thanks to Nate Geschwill ([@NathanielGeschwill][ghNate]) for helping me
> flesh out these scripts.

[ghNate]:https://github.com/NathanielGeschwill

## Scripts

To use these batch scripts, you must have the following dependencies met:

- git
- [git-p4](https://www.atlassian.com/git/tutorials/git-p4)
- git lfs
- p4
- gh
- Command Prompt (these are batch scripts after all)

These scripts also interact with GitHub and Perforce servers.

You will need to verify that you have the following permissions on Perforce:

- Migrate
  - Read permissions to depots that you are migrating
  - Create repo permissions to the user/org you are migrating to
- Clean
  - Super permissions to depots you are scrubbing/"cleaning" from the server

### P4 Migrate

The [migrate script](bin/p4migrate.bat) recreates the full history of revisions
relevant to a specific depot in a Git repository. The repository is then
migrated from a basic Git repo to one that contains LFS artifacts with settings
that mirror our P4 typemap.

The script also takes care of creating the local and remote repositories and
pushing the contents. No changes are made to depots.

To specify which files to migrate, write a `target.txt` file with P4 file
specs separated by newlines and place it in your working directory.

The account to upload to and topic tags to apply are defined by env vars:

- `GIT_ARCHIVE_ACCOUNT` should be an account (ex: `AIE-Seattle-Prog`)
- `GIT_ARCHIVE_TAGS` should be a comma-separated set of tags (ex: `production,perforce-archive`)

### P4 Clean

The [clean script](bin/p4clean.bat) scrubs a depot from the P4 server by forcing
the server to populate any "lazy links" to files referenced by the depot,
**obliterating** the files within the depot, and then deleting the depot itself.

This is a **very destructive** script and does not provide many points for
validation and testing. Ensure that you are only deleting depots that you intend
to lose forever.

> :warning: This uses `p4 obliterate` to scrub a depot from the P4 server.

As with the migration script, this assumes a `target.txt` file with P4 file
specs separated by newlines.

## License

MIT License - Copyright (c) 2022 Academy of Interactive Entertainment

For more information, see the [license][lic] file.

[lic]:LICENSE.md
