# The tap formula, chris-mclennan/homebrew-tap Formula/mnml.rb.
#
# A template: bump-homebrew-tap.yml fills the 0.3.3 and @SHA_*@ slots from
# the release's sha256.sum and commits the result to the tap. Keep it a
# formula the tap can take verbatim — the four url/sha256 pairs, the
# bin.install, the --version test — so the tap needs no script of its own to
# know mnml-zig's asset names.
class Mnml < Formula
  desc "NvChad-style terminal IDE"
  homepage "https://mnml.sh"
  version "0.3.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-apple-darwin.tar.xz"
      sha256 "6cae6d91a3db41a88f39d6ccc673033b58b5a09d046eb8cc98067bbca353110e"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-apple-darwin.tar.xz"
      sha256 "eb1fac65e5dc593f75b02c9fbced3700e08f120e18bf93595c6462f4df9423b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "afe01cae5e539b35911a27c53ca22c9327e5895b0f80ef6fccccc7ab1169ef07"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a502540ba57909e5074a89044784324d1527279ba130866e4a7db0cd170ea58b"
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
