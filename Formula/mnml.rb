class Mnml < Formula
  desc "NvChad-style terminal IDE in Rust"
  homepage "https://mnml.sh"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-apple-darwin.tar.xz"
      sha256 "bd1bba329552dd9b89e52cb76518f1555236e503fb0585f7c4977a2280d82772"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-apple-darwin.tar.xz"
      sha256 "8db7da7b62f185c343fff81ac67a9fabd2c8ef0733bfca7da041d3d60ea3a510"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ea4940f0af01326163337a433b5c6fe888a4378897ad042ab12b347a5efba429"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b2d314d6e78e3c9a47a240688fc2b8d73dd96c964defbfb0a6d9e75b218e912f"
    end
  end

  def install
    bin.install "mnml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mnml --version")
  end
end
