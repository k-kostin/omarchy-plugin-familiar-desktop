# Official titlebars — issue #74

The `dev/v0.1.6` branch implements an **explicit handoff to Core-managed
controls**. It does not reproduce Familiar's Mac/Windows controls on the official
renderer. No release or desktop acceptance is implied.

## Ownership and behaviour

Core [#14482](https://github.com/omacom/omarchy/pull/14482) merged on 11 October
2026 at `14987189695a8ae1f2270262fdf77446fafb1ba3`. Package
[#957](https://github.com/omacom/omarchy-pkgs/pull/957) builds
[`omacom/omarchy-hyprland-titlebars` v0.2.0](https://github.com/omacom/omarchy-hyprland-titlebars/tree/v0.2.0).
The package lives at `/usr/lib/omarchy-hyprland-titlebars/titlebars.so`.
Core's `default/hypr/workspace-modes.lua` owns its load requests, global button
list, theme and `omarchy-floating-workspace` scope. Familiar does not overwrite
these, change workspace layouts, install/remove packages or switch channels.
The package and Hyprland enforce ABI compatibility; Familiar never probes it by
loading/unloading a second plugin. Plugin registration names do not prove origin.

In **Windows → Window controls**, choose **Use Omarchy controls**. This explicit
choice replaces the old conflict-only state. Core supplies close/maximise and
floating-workspace bars (Super+L); minimise is available from Familiar's dock.
Familiar's Mac/Windows styles, size, browser/class exclusions and theme policy
remain saved but inactive, and those controls are hidden in this mode. Off or
unloading Familiar does not turn off Core's bars. The UI says who owns them.
`managed` reports delegation to an available Core API, not proof of visible bars
or a loaded plugin: Core legitimately leaves it unloaded on tiled workspaces.

Custom rendering parity would require a separate supported ownership/renderer
contract. It is not part of this native handoff and must not be described as done.
Existing installations without the official package retain their previous private
backend. New setup on an official-package host downloads only Familiar's helper.

## Migration and recovery

The helper's `titlebars migrate` command validates the exact owned include and
installation identity before editing anything. It keeps the inert include and
legacy ownership fields to allow rollback to a guarded older version, replaces
only Familiar's generated loader with a comment, and journals the delegation.
It never reloads, loads or unloads a compositor backend. No user preference is
changed. A failed/interrupted write reports `migration-required`; retry the same
button. Once delegation is recorded, reconciliation cannot recreate the private
loader, even if the system package is subsequently removed.

When a previous private owner exists, migration records the current
`HYPRLAND_INSTANCE_SIGNATURE` and reports `restart-required` until a different,
nonempty session is seen. Log out and back in; a shell restart is insufficient.
Without a session signature it refuses migration rather than claiming retirement.
Fresh native setup needs no private library and no forced restart. Missing Core
support reports `core-required`; missing package reports `package-missing`.

`titlebars remove` removes only the exact Familiar include and retains the
handoff receipt/preferences. It never removes Omarchy's package or alters its
configuration. Edited/foreign hooks stop for review.

## Development installation and rollback

The source-bound development installer now permits the official package. It
skips private-backend setup/disable and the private ABI gate in that path, while
still verifying the bundled helper and source identity. Existing working private
installations retain their private bytes in snapshots for older-Omarchy rollback;
those bytes are not loaded on an official host. This pipeline still targets
Linux x86_64 and requires the existing complete installation documented in
[DEVELOPMENT.md](DEVELOPMENT.md).

Official-host source transitions allow the audited v0.1.5 commit
`439f97480bb0803f32137dcb700fbb939dc959ff` and trusted source with the handoff-v1
contract marker. Pre-guard targets are refused before desktop/source activation.
Rollback to v0.1.5 restores its guarded, paused-controls behaviour; it does not
restore private controls over Core. The official package remains installed.
Keep the bundle and snapshot, and do not delete a retained include before testing
rollback to an older source that expects it.

## Evidence and acceptance still required

Rust regressions cover fresh/legacy handoff, session transition, no compositor
mutation, preference preservation, absent package/Core, interrupted writes and
foreign/edited hooks. Installer fixtures cover official install/rollback without
private setup, unsafe target refusal and no package changes. QML tests exercise
explicit selection and serialized completion.

Before merge, test the exact development artifact on the XPS: migration, logout/
login, Core Super+L cycle, actual controls, theme changes, multiple windows,
disabling/removing Familiar, package absence, and rollback. Green CI is not XPS
acceptance. Keep #74 open until Tom accepts the native handoff and the tested
behaviour; do not claim Mac/Windows titlebar parity or close it automatically.
