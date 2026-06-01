#!/usr/bin/env bash
# Bump a formula or cask in this tap to match the latest release of the
# given upstream app. Run from a CI job in the app repo, or locally.
#
# Usage: scripts/bump.sh <app> <version>
#   <app>     = mnml | mixr | tmnl
#   <version> = 0.1.2 (no leading 'v')
#
# Reads SHA256s from the upstream release's sha256.sum (for tarballs),
# or computes them on the fly (for DMGs, which aren't in sha256.sum
# because cargo-dist doesn't sign them).
set -euo pipefail

app="${1:?app required (mnml|mixr|tmnl)}"
version="${2:?version required (no leading v)}"

base="https://github.com/chris-mclennan/${app}/releases/download/v${version}"
sha_file=$(mktemp)
trap "rm -f $sha_file" EXIT
curl -sL --fail -o "$sha_file" "$base/sha256.sum"

# Extract a SHA256 for a given artifact filename (positive match).
sha_for() {
  awk -v f="$1" '$2 == "*"f {print $1; exit}' "$sha_file"
}

# Compute SHA256 for a remote file (used for DMGs).
sha_remote() {
  local url="$1"
  local tmp
  tmp=$(mktemp)
  curl -sL --fail -o "$tmp" "$url"
  shasum -a 256 "$tmp" | awk '{print $1}'
  rm -f "$tmp"
}

case "$app" in
  mnml|mixr)
    class_name="${app^}"  # capitalize first letter
    sha_arm_mac=$(sha_for "${app}-rs-aarch64-apple-darwin.tar.xz")
    sha_x64_mac=$(sha_for "${app}-rs-x86_64-apple-darwin.tar.xz")
    sha_arm_linux=$(sha_for "${app}-rs-aarch64-unknown-linux-gnu.tar.xz")
    sha_x64_linux=$(sha_for "${app}-rs-x86_64-unknown-linux-gnu.tar.xz")

    if [ "$app" = "mnml" ]; then
      desc="NvChad-style terminal IDE in Rust"
      homepage="https://mnml.sh"
    else
      desc="Lean terminal DJ app for electronic music"
      homepage="https://mixr.sh"
    fi

    cat > "Formula/${app}.rb" <<EOF
class ${class_name} < Formula
  desc "${desc}"
  homepage "${homepage}"
  version "${version}"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/${app}/releases/download/v#{version}/${app}-rs-aarch64-apple-darwin.tar.xz"
      sha256 "${sha_arm_mac}"
    else
      url "https://github.com/chris-mclennan/${app}/releases/download/v#{version}/${app}-rs-x86_64-apple-darwin.tar.xz"
      sha256 "${sha_x64_mac}"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/${app}/releases/download/v#{version}/${app}-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "${sha_arm_linux}"
    else
      url "https://github.com/chris-mclennan/${app}/releases/download/v#{version}/${app}-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "${sha_x64_linux}"
    end
  end

  def install
    bin.install "${app}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/${app} --version")
  end
end
EOF
    echo "Updated Formula/${app}.rb to v${version}"
    ;;

  tmnl)
    sha_arm_dmg=$(sha_remote "${base}/tmnl-rs-aarch64-apple-darwin.dmg")
    sha_x64_dmg=$(sha_remote "${base}/tmnl-rs-x86_64-apple-darwin.dmg")

    cat > "Casks/tmnl.rb" <<EOF
cask "tmnl" do
  version "${version}"

  on_arm do
    sha256 "${sha_arm_dmg}"
    url "https://github.com/chris-mclennan/tmnl/releases/download/v#{version}/tmnl-rs-aarch64-apple-darwin.dmg"
  end

  on_intel do
    sha256 "${sha_x64_dmg}"
    url "https://github.com/chris-mclennan/tmnl/releases/download/v#{version}/tmnl-rs-x86_64-apple-darwin.dmg"
  end

  name "tmnl"
  desc "GPU-rendered terminal with a structured-cell display protocol"
  homepage "https://tmnl.sh"

  app "tmnl.app"

  zap trash: [
    "~/.config/tmnl",
    "~/Library/Application Support/sh.tmnl",
    "~/Library/Caches/sh.tmnl",
    "~/Library/Preferences/sh.tmnl.plist",
  ]
end
EOF
    echo "Updated Casks/tmnl.rb to v${version}"
    ;;

  *)
    echo "Unknown app: $app (expected mnml|mixr|tmnl)" >&2
    exit 2
    ;;
esac
