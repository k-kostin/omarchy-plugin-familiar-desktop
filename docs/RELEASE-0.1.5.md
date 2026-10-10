# v0.1.5 release record

Prepared on `v0.1.5`, [PR #81](https://github.com/tcballard/omarchy-plugin-familiar-desktop/pull/81), at Tom's request on 10 October 2026. General, Windows and Mac layouts remain in scope. The Mac-only proposal and further decomposition of the largest components are deferred. Full official-titlebar migration (#74) remains separate.

## Tested development boundary

Source: `87a81d702360a0f02a242772c2fe1a6d1152146b`; tree: `5c5d51982bf7738b48c081067d7f016e9a9efb95`. This development build still reports product version 0.1.4.

Tom reported after installing and testing this candidate:

> OK, everything seems to be working...

He then requested release preparation and deferred the Mac-only work:

> Yeah ok, lets prep for this then - we are gonna defer the mac-only astuff

These are overall test feedback and authorization to prepare the release. No individual checklist results, current XPS model, installed Omarchy/Hyprland versions, scaling or rollback snapshot path were supplied in this report. Do not substitute the previous release's environment or infer physical keyboard/trackpad, multi-monitor or Qt 6.12 results. The later promotion instruction is recorded below under [WORKFLOW.md](WORKFLOW.md).

All of the following passed for the tested source, attempt 1:

| Evidence | Run |
| --- | --- |
| Portable checks, PR | [38068482802](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38068482802) |
| Portable checks, push | [38068480050](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38068480050) |
| Binary validation | [38068483012](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38068483012) |
| Development bundle | [38068482995](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38068482995) |
| Three desktop smoke jobs | [38068483132](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38068483132) |

Downloaded development artifact: `familiar-dev-87a81d702360a0f02a242772c2fe1a6d1152146b-38068482995-1`, artifact `11676002510`; ZIP SHA-256 `3176b335476ba6e0592548cf7509885072439f824938f2b11140036c4febb023`. GitHub's digest, every `SHA256SUMS` entry and `DEV-BUILD.json` source/run/attempt matched. Backend SHA-256: `4f7dc35d82fe774ae91d8fa11b8c910496ec56cf2cb7755b2c6d6cfa6b983578`. Hyprbars SHA-256: `7eb0f6162b7342346a9a7c309d067d1634d79dfd71a5ec3c0132d46635b3dc06`.

Downloaded desktop receipts matched that source/run/attempt and both binary digests. All reported `phase: passed`, `exitCode: 0` and a separate, active RSS panel with glyph U+F09E.

| Omarchy Core | Qt / Quickshell | Artifact | ZIP SHA-256 |
| --- | --- | --- | --- |
| `0f8af9be307d5d4f12cc0f6394892cac651ed5e6` | 6.11.2 / 0.3.1 | `11675786898` | `69f728c16311e3e41cf20786a72ec26bae34647c8e9e25ab97aa7cf24f0ab991` |
| `f99d33a8ddee7b36509a71a6d20d5d23355ce8b1` | 6.11.2 / 0.3.1 | `11675353917` | `150a4d203960904d688ef17a9aeed618a2b0e48d393956e6acf2882bd36239ca` |
| `b83d3df0840504299d3099ebf391eb8110527edd` | 6.12.0 / 0.3.2 | `11675933039` | `715baea2cd267dbcb24fbb6e67769743c1cbb93739712214f21d3db8fd6e451a` |

Local checks at this boundary also passed Rust formatting/Clippy, the existing Node groups, 306 QtTest cases, six production settings/bar render cases and QML parsing. The canonical local check encountered the recorded process-visibility restriction; canonical CI passed with that test enabled.

## Release changes and remaining gates

Preparation changes version metadata to 0.1.5, the three versioned download selectors, release documents and README status. Production QML/JavaScript, Rust implementation and dependency versions remain byte-identical to the tested development boundary. The version change alters the backend executable; the old development digest does not become the 0.1.5 release pin.

The release-version backend was measured from source `b5f09e3bc2675aa31919377794fdcb498483a0fe`, tree `19ebb7782d8ac7fbacf6386e9f67c471a0268264`, [binary run 38083668720](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38083668720), attempt 1. Artifact `11680894119` (`familiar-desktop-packaging-validation`) had ZIP SHA-256 `0f546abeb19129e03ae5526cc8b945407328086e1200d50db3e50316d49798d4`, matching GitHub. All checksum entries and 272 source-file digests matched; the backend reports `familiar-desktop 0.1.5`. Its reviewed SHA-256 is `8be442335e0143ddde0577aa000c7950eaa3f0090413760fb9cbc900c4739e43`. Hyprbars reproduced the existing digest `7eb0f6162b7342346a9a7c309d067d1634d79dfd71a5ec3c0132d46635b3dc06`.

That measurement bundle was validation-only with `sourcePinsMatch: false`; it is not a publishable artifact. Commit `8d582674cb4ee86d0489e10982dd0351b7c2e3af`, tree `40595138c9a2ea63a720b07e2921528c5c7b0c77`, records the measured pin and reproduces it in a strict release bundle with `sourcePinsMatch: true`.

All five current-source runs passed: [portable PR 38083946746](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38083946746), [portable push 38083943932](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38083943932), [release binaries 38083946908](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38083946908), [development build 38083946924](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38083946924) and [three desktop smoke jobs 38083947157](https://github.com/tcballard/omarchy-plugin-familiar-desktop/actions/runs/38083947157), including Qt 6.12.0 / Quickshell 0.3.2.

Downloaded strict artifact `11681573159` (`familiar-desktop-release`) from development run `38083946924`, attempt 1, had ZIP SHA-256 `482166cf7778dc599aec9d5004e201345ac73ca52156233503ec9d3fff96543e`, matching GitHub. Every checksum entry, all 272 source-file digests, source/tree/version identities, document and asset hashes, SPDX metadata and source-archive pins matched. Both actual installers embed this source SHA. CI's reviewed-bundle smoke exercised the shipped download installers with both real binaries using fixture transport. The backend reports `familiar-desktop 0.1.5` and both binaries reproduce the committed pins.

The downloaded development artifact `11681463402` had ZIP SHA-256 `5090f8296dc8f8fd1dac22c7991270b3ec52152043eb09e77be73193e52a47db`. All checksums and source/run/attempt identities matched. All three downloaded desktop receipts identified this source, version and both binary hashes; every result reported `phase: passed`, `exitCode: 0`, and a separate, active RSS panel with glyph U+F09E. Their exact artifact identities and ZIP digests are recorded in PR #81.

## Acceptance and promotion authorization

After the completed preparation, green current-source checks and verified artifacts were reported, Tom instructed on 10 October 2026:

> OK, we should get this released

This accepts the prepared v0.1.5 scope and authorizes both merging PR #81 and final v0.1.5 publication after the required merged-main checks. It applies to `8d582674cb4ee86d0489e10982dd0351b7c2e3af` plus the final documentation-only changes that record this instruction and remove the preparation notices. General, Windows and Mac layouts remain included.

The physical XPS report remains bound to `87a81d7`; no reinstall or itemized physical test of `8d58267` is claimed. The intervening release metadata, download-selector and binary-pin changes were reviewed and checked by the source-bound installer/build/desktop tests above. Tom's later release instruction authorizes promotion of that reviewed release candidate without another physical reinstall. This scoped instruction does not waive acceptance requirements for future runtime or installer changes. Final documentation-only changes require no new desktop acceptance; current merged-main portable and strict binary checks remain mandatory.

The checklist below records the state before merging. The resulting main SHA, current-main CI, annotated tag, published assets and public setup/retry evidence are recorded in [PR #81](https://github.com/tcballard/omarchy-plugin-familiar-desktop/pull/81) after promotion, avoiding guessed or self-referential source identities.

- [x] Release scope and reporter acknowledgements prepared in [v0.1.5.md](v0.1.5.md).
- [x] Positive XPS result recorded for the development boundary above.
- [x] Measure the 0.1.5 backend from source-bound CI and commit its reviewed digest; retain the independently checked Hyprbars digest.
- [x] Rebuild and verify a strict `familiar-desktop-release` artifact with `sourcePinsMatch: true`, complete checksums and both actual installers.
- [x] Record current-source portable/build/desktop evidence and inspect the release-only diff against the tested boundary.
- [x] Record acceptance of the final candidate and Tom's merge authorization.
- [ ] Require green merged-main checks and matching source/binary identities.
- [x] Record authorization for final v0.1.5 publication and remove the pending notice.
- [ ] Dispatch **Tag verified release** for the exact accepted main SHA, with RC empty, then verify uploaded/public assets and fresh setup/retry.
- [ ] Publish prepared issue follow-ups only when authorized and the claimed release exists.

No v0.1.5 tag, GitHub Release, marketplace submission or public download is created by preparation. Final tag/asset identities and the merged-main SHA must be recorded after those actions, rather than guessed in advance. Follow [RELEASE-CHECKLIST.md](RELEASE-CHECKLIST.md). Development installation and rollback use [DEVELOPMENT.md](DEVELOPMENT.md); keep the snapshot path printed by the installer.

## Static preflight boundary

The installed release preflight was run against clean clones of the tested source, release-version source `b5f09e3bc2675aa31919377794fdcb498483a0fe` and pinned candidate `8d582674cb4ee86d0489e10982dd0351b7c2e3af`, including its downloaded strict assets. Strict manifest/path validation passed with no errors or warnings, and asset validation found no errors. The advisory security scan returned `sudoers-dangerous-passwordless-command` for the disposable desktop VM's `tests/desktop/vm.sh` fixture. Manual inspection confirms that cloud-init grants this permission inside the temporary guest overlay, with a checksum-pinned base image, localhost-only SSH forwarding, no host-directory mount, and cleanup of guest disks and ephemeral keys. The preflight still returns failure for the fixture rule; this is not a passing scan or a claim of runtime security. Installer, process, workflow dependency and distributed agent-instruction advisories remain limited scan results. No scanner rule was suppressed or changed. The initial run against the development checkout also hit its safety limit on local `backend/target` output; the clean clone avoided those generated files.

## Follow-up scope

[Prepared issue messages](RELEASE-0.1.5-FOLLOWUPS.md) distinguish the five included fixes from #74 and the eighteen future Dock enhancements under #46. The earlier code review also identified possible repeated hosted-widget signal attachment, overlapping refresh work and a legacy launch-focus dispatch path. They are review concerns, with no XPS reproduction recorded in this report; release preparation does not claim to fix them or complete broader dock parity.
