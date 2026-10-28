# Contributing

Issues and pull requests are welcome. Keep changes focused and do not include
personal screenshots, machine-specific configuration, build output, or
unrelated Noctalia source.

## Patch changes

The patch targets Noctalia commit
`125a30d4f13e86200e704a013d17ac0ed88a8044` (`v5.4.0`). Make and validate
changes against that exact source revision, then regenerate the patch:

```sh
git -C /path/to/noctalia diff --binary --full-index 125a30d4f13e86200e704a013d17ac0ed88a8044 -- \
  src/shell/dock/dock.cpp src/shell/dock/dock.h \
  src/shell/dock/dock_context_menu.cpp src/shell/dock/dock_context_menu.h \
  src/shell/dock/dock_instance.h src/shell/dock/dock_items.cpp \
  src/shell/dock/dock_items.h src/ui/controls/image.cpp src/ui/controls/image.h \
  > patches/noctalia-v5.4.0-window-previews.patch
```

Check the generated patch against a pristine checkout:

```sh
scripts/check-patch.sh /path/to/pristine/noctalia-v5.4.0
```

Also run `git diff --check` and build/test the patched Noctalia source before
submitting. If rebasing to another Noctalia release, update the base commit,
compatibility notes, and check script together.
