# P4 to Git Archive

This contains a set of scripts that operate on P4 depots specified by lines in a
"target.txt" file in the working directory.

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
- git lfs
- p4
- gh
- Command Prompt (these are batch scripts after all)

These scripts also interact with GitHub and Perforce servers. You will need to
verify that you have the following permissions:

- Read permissions to depots that you are migrating
- Super permissions to depots you are scrubbing/"cleaning" from the server
- Create repo permissions to the user/org you are migrating to

### P4 Migrate

The [migrate script](bin/p4migrate.bat) recreates the full history of revisions
relevant to a specific depot in a Git repository. The repository is then
migrated from a basic Git repo to one that contains LFS artifacts with settings
that mirror our P4 typemap.

The script also takes care of creating the repository abn

This makes no changes to the depots itself and is safe to run.

### P4 Clean

The [clean script](bin/p4clean.bat) scrubs a depot from the P4 server by forcing
the server to populate any "lazy links" to files referenced by the depot,
**obliterating** the files within the depot, and then deleting the depot itself.

This is a **very destructive** script and does not provide many points for
validation and testing. Ensure that you are only deleting depots that you intend
to lose forever.

## License

MIT License - Copyright (c) 2022 Academy of Interactive Entertainment

For more information, see the [license][lic] file.

[lic]:LICENSE.md
