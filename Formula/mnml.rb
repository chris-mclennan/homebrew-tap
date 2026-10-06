# The tap formula, chris-mclennan/homebrew-tap Formula/mnml.rb.
#
# A template: bump-homebrew-tap.yml fills the 0.3.4 and @SHA_*@ slots from
# the release's sha256.sum and commits the result to the tap. Keep it a
# formula the tap can take verbatim — the four url/sha256 pairs, the
# bin.install, the --version test — so the tap needs no script of its own to
# know mnml-zig's asset names.
class Mnml < Formula
  desc "NvChad-style terminal IDE"
  homepage "https://mnml.sh"
  version "0.3.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-apple-darwin.tar.xz"
      sha256 "db750f613a97a2128147747a5ffe992841da191bd2b029df14f79a93cd31ec81"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-apple-darwin.tar.xz"
      sha256 "d5992e353073f7a4fc19d6c80b1b757e660a55a61384135da2b144c416f8b02b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c4a3767f8e37707d8994536fdd4e53ef7b03e1d8690c11940af1e52c48776a7e"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d63d3660cea28a7877ead38d7bf6e5e6fbbe2b85cdde4a9bd60cb859ed20f43e"
    end
  end

  def install
    bin.install "mnml"
    # The offline Jira and Bitbucket `mnml --demo` starts from the
    # binary's own directory, so they go in `bin` beside it.
    bin.install "mnml-fake-jira" if File.exist?("mnml-fake-jira")
    bin.install "mnml-fake-bitbucket" if File.exist?("mnml-fake-bitbucket")
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
