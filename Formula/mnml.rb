# The tap formula, chris-mclennan/homebrew-tap Formula/mnml.rb.
#
# A template: bump-homebrew-tap.yml fills the 0.3.1 and @SHA_*@ slots from
# the release's sha256.sum and commits the result to the tap. Keep it a
# formula the tap can take verbatim — the four url/sha256 pairs, the
# bin.install, the --version test — so the tap needs no script of its own to
# know mnml-zig's asset names.
class Mnml < Formula
  desc "NvChad-style terminal IDE"
  homepage "https://mnml.sh"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-apple-darwin.tar.xz"
      sha256 "04fcd33ab746074370874e848b4eac1f86efbc5cc4d4658d439e72110d470a73"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-apple-darwin.tar.xz"
      sha256 "5a8c1bb693de80c0d63628cbb9d8a29dc2f0ac343ea9b2ccd2aa73e332a0bab1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b7fada34c3c747cdfd876a0fe0b1322a88bca29f2fe4d83ef0b8c039696a5800"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "442084da2198e9a01b4906457cb77f1a99d44f17d774d5547eede001616d4d8f"
    end
  end

  def install
    bin.install "mnml"
    # The curated Lua script set the archive carries as share/mnml/lua.
    # `bin` is <prefix>/bin and `pkgshare` is <prefix>/share/mnml, so the
    # installed binary finds it as `<exe dir>/../share/mnml/lua` — the
    # same path the .deb and .rpm use. Without it the SCRIPTS section's
    # Marketplace tab is empty on a brew install.
    pkgshare.install "share/mnml/lua" if File.directory?("share/mnml/lua")
    # MnmlSymbols.ttf, the face mnml's own marks are drawn from. Laid
    # beside the scripts; `brew install --cask font-...` is not a thing
    # for a font mnml builds itself, so the user points their terminal
    # at this path (or copies it into ~/Library/Fonts).
    pkgshare.install "share/mnml/fonts" if File.directory?("share/mnml/fonts")
    # The mnml catalogue — the INTEGRATIONS section's Marketplace tab
    # default source, probed beside the script set. Without it that tab
    # is empty on a brew install.
    pkgshare.install "share/mnml/marketplace.zon" if File.exist?("share/mnml/marketplace.zon")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mnml --version")
  end
end
