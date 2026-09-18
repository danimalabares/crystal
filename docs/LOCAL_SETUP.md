# Local installation and aliases

The setup was prepared in a remote workspace, not on Dani's Mac. No Mac shell
configuration or `~/dr` directory has been modified. The `$alias` skill was not
available in this session, so no aliases have been invented or installed.

The public repository exists, but the prepared snapshot still needs uploading.
Follow the terminal handoff to publish it. Clone it on the Mac:

```sh
mkdir -p ~/dr
git clone https://github.com/danimalabares/crystal.git ~/dr/crystal
```

`git clone` refuses to overwrite an existing nonempty destination. If the local
directory already exists, inspect its files, Git remote, and status before doing
anything to it.

Then ask Terminal Claude to read this file, `CLAUDE.md`, and the local `$alias`
skill and finish alias installation for the project name `crystal`. It should
inspect the current alias conventions and collisions, preserve existing work,
and report the exact aliases it creates. If the skill is unavailable locally,
report that limitation instead of guessing its behavior.

The explanation requirement is already at
`~/dr/crystal/dani-explanations-request.md`; Terminal Claude can read that path.
No chat attachment is required.
