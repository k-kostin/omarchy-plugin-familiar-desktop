#!/usr/bin/env bash
# Explicit contributor build; never called by the hosted shell or setup UI.
set -Eeuo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"
[[ $# == 1 ]] || { echo 'Usage: bash scripts/build-local-dev.sh OUTPUT_DIRECTORY' >&2; exit 2; }
output="$(realpath -m -- "$1")"
[[ -z "$(git status --porcelain --untracked-files=all)" ]] || { echo 'Commit source changes before building.' >&2; exit 1; }
source_sha="$(git rev-parse HEAD)"
architecture="$(uname -m)"
case "$architecture" in x86_64) machine='Advanced Micro Devices X86-64';; aarch64) machine='AArch64';; *) echo 'Requires Linux x86_64 or aarch64.' >&2; exit 1;; esac
[[ "$(uname -s)" == Linux ]] || exit 1
abi="$(hyprctl version | sed -n 's/^Version ABI string: //p')"
[[ "$abi" =~ ^[a-zA-Z0-9_.-]+$ ]] || { echo 'Cannot read the running Hyprland ABI.' >&2; exit 1; }
work="$(mktemp -d)"
trap 'rm -rf -- "$work"' EXIT
cargo build --manifest-path backend/Cargo.toml --locked --release
bash scripts/build-hyprbars.sh --local
# Package only this target; stale assets from previous builds never enter it.
dir="$work/downloaded/local"
mkdir -p "$dir"
backend_asset="familiar-desktop-linux-$architecture"
library_asset="hyprbars-linux-$architecture-$abi.so"
install -m755 backend/target/release/familiar-desktop "$dir/$backend_asset"
install -m644 "hyprbars-assets/$library_asset" "$dir/$library_asset"
for asset in "$backend_asset" "$library_asset"; do
  readelf -h "$dir/$asset" | grep -q "$machine"
done
[[ -z "$(git status --porcelain --untracked-files=all)" && "$(git rev-parse HEAD)" == "$source_sha" ]] || { echo 'Source changed during the build; bundle refused.' >&2; exit 1; }
node - "$dir" "$source_sha" "$backend_asset" "$library_asset" <<'JS'
const fs=require('node:fs'),path=require('node:path'),crypto=require('node:crypto');
const [dir,sha,...names]=process.argv.slice(2);
const digest=name=>crypto.createHash('sha256').update(fs.readFileSync(path.join(dir,name))).digest('hex');
const version=JSON.parse(fs.readFileSync('manifest.json')).version;
fs.writeFileSync(path.join(dir,'RELEASE-MANIFEST.json'),JSON.stringify({version,source:{commit:sha},artifacts:names.map(name=>({name,sha256:digest(name)}))}));
fs.writeFileSync(path.join(dir,'SHA256SUMS'),[...names,'RELEASE-MANIFEST.json'].map(name=>`${digest(name)}  ${name}\n`).join(''));
JS
node scripts/prepare-dev-bundle.cjs --local "$work/downloaded" "$output"
cp hyprbars-assets/HYPRBARS-{BUILD,ELF,LICENSE}.txt "$output/"
(cd "$output"; for file in ./*; do [[ "$file" == ./SHA256SUMS || "$file" == ./SHA256SUMS.new ]] || sha256sum "$file"; done > SHA256SUMS.new; mv SHA256SUMS.new SHA256SUMS)
printf '\nLocal native build: %s\nABI: %s\nSource: %s\nInstall on this desktop: FAMILIAR_SOURCE_REPOSITORY=%q bash %q --initial\n' "$architecture" "$abi" "$source_sha" "$root" "$output/install-dev.sh"
