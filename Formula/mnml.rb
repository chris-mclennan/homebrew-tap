# The tap formula, chris-mclennan/homebrew-tap Formula/mnml.rb.
#
# A template: bump-homebrew-tap.yml fills the 0.3.0 and @SHA_*@ slots from
# the release's sha256.sum and commits the result to the tap. Keep it a
# formula the tap can take verbatim — the four url/sha256 pairs, the
# bin.install, the --version test — so the tap needs no script of its own to
# know mnml-zig's asset names.
class Mnml < Formula
  desc "NvChad-style terminal IDE"
  homepage "https://mnml.sh"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-apple-darwin.tar.xz"
      sha256 "b4608575b390e21630fbe9bcb28a0a33dff4b1580b8b4ec39b48286ff97d91ce"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-apple-darwin.tar.xz"
      sha256 "d82f0b5891c59ce747dab5ec9567b177db712b3954c5e85719b98577cc45aa7c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7998341205fdfded26252cbdd714522ecf3ea91e4028cb464a4db29d96580358"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4bcff5ae90f9fae94262df79eb028895a7065ba6441e943254831e264ad34bef"
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
