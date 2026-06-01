class Mixr < Formula
  desc "Lean terminal DJ app for electronic music"
  homepage "https://mixr.sh"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mixr/releases/download/v#{version}/mixr-rs-aarch64-apple-darwin.tar.xz"
      sha256 "9f8015c0e01da17ea5935b142df680be06388b2b6eb93ccc6539111e731d5999"
    else
      url "https://github.com/chris-mclennan/mixr/releases/download/v#{version}/mixr-rs-x86_64-apple-darwin.tar.xz"
      sha256 "d603afba7cfac8465ae2f14ef291dcecc0640975aa260250424c51a07b484d5c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mixr/releases/download/v#{version}/mixr-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a72cc7880fc86ca6ad8894c2b19242bbb2eca9ecce073a56e7838a91b10ac2a5"
    else
      url "https://github.com/chris-mclennan/mixr/releases/download/v#{version}/mixr-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "23bed966560513dc97f3a526831866dd5ed06c8333cbed56d6e472435a53194a"
    end
  end

  def install
    bin.install "mixr"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mixr --version")
  end
end
