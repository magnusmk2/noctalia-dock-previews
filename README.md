# Noctalia Dock Window Previews

Hover over a dock item to see the windows belonging to that application. This
downstream patch adds per-window previews to the Noctalia dock, including a
window title, an activation target, and a close button.

This is a source patch for **Noctalia v5.4.0**. It is not a Noctalia plugin and
cannot be installed from Noctalia's plugin manager. Noctalia's dock source must
be patched and rebuilt.

## What it does

- Shows previews after hovering over an application in the dock.
- Lists all windows for the dock item, with horizontal scrolling when needed.
- Uses Noctalia's screencopy capture support for window images.
- Click a preview to activate that window; click its borderless `×` to close it.
- Keeps the preview panel attached to the dock item and follows dock opacity.
- Highlights the preview under the pointer and dismisses the panel when the
  pointer leaves the dock/preview area.

The hover delay is 850 ms. Preview images are captured from the compositor, so
availability and image content depend on compositor support and the state of
each window. Protected or minimized surfaces may not provide a useful image.

## Apply the patch

Clone Noctalia and check out the supported base version:

```sh
git clone https://github.com/noctalia-dev/noctalia.git
cd noctalia
git checkout v5.4.0
```

Download this repository, then apply and verify the patch from the Noctalia
source directory:

```sh
git apply /path/to/noctalia-dock-previews/patches/noctalia-v5.4.0-window-previews.patch
git diff --check
```

To check compatibility without changing the source tree, run:

```sh
/path/to/noctalia-dock-previews/scripts/check-patch.sh /path/to/noctalia
```

Then follow Noctalia's [build and installation guide](https://github.com/noctalia-dev/noctalia/blob/v5.4.0/BUILDING.md).
In particular, build and install using the same layout you normally use for
Noctalia. Keep a way to revert to your previous build if you need to roll back.

## Validation

The patch is pinned to upstream commit `125a30d4f13e86200e704a013d17ac0ed88a8044`
(tag `v5.4.0`). The check script verifies that base and confirms the patch
applies. The implementation was built and exercised against that Noctalia
checkout; its upstream test suite passed (170 tests) during development. This
does not imply testing across all compositors or Noctalia versions.

GitHub Actions checks the patch against the pinned upstream commit. For future
releases, pushing a `vX.Y.Z` tag validates that a matching changelog section
exists, then publishes the patch file as a GitHub Release asset.

## Releases

Add release notes under the matching version heading in `CHANGELOG.md`, commit
the change, and push a tag such as `v0.2.0`. The release workflow verifies the
patch before publishing `noctalia-v5.4.0-window-previews.patch`. GitHub also
provides source archives for the tagged repository automatically.

## Compatibility and limitations

- Supported base: Noctalia v5.4.0 only. The patch may need adaptation for later
  releases.
- This changes Noctalia's core dock implementation; it is not an independent
  extension.
- The patch adds image capture and popup handling to the dock. Compositor
  screencopy support and the relevant Noctalia build dependencies are required.
- Review the patch and build it locally. This repository does not provide
  binaries or run an installer on your system.

## License

The patch contains changes to Noctalia source files, which are distributed
under Noctalia's MIT license. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)
for the upstream notice. The original documentation and scripts in this
repository are also MIT licensed; see [LICENSE](LICENSE).
