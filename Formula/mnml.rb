# The tap formula, chris-mclennan/homebrew-tap Formula/mnml.rb.
#
# A template: bump-homebrew-tap.yml fills the 0.3.5 and @SHA_*@ slots from
# the release's sha256.sum and commits the result to the tap. Keep it a
# formula the tap can take verbatim — the four url/sha256 pairs, the
# bin.install, the --version test — so the tap needs no script of its own to
# know mnml-zig's asset names.
class Mnml < Formula
  desc "NvChad-style terminal IDE"
  homepage "https://mnml.sh"
  version "0.3.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-apple-darwin.tar.xz"
      sha256 "e716f195c04dbcec2bf533a4180a17a17e666f5e157fe15980c7c172c6b62c01"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-apple-darwin.tar.xz"
      sha256 "a7d901e6adf2d9876c2288f48113cb073b55f33cca92548ee5ccbdb5d2b4c99a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "26281a4189bb9c7bf53825275395a9b7fcca86a66a31f195635765b64a62fef9"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60927fa60a892038f60c31f11297b71ea68410be37c5bef030ad0cf1ca9105b0"
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
