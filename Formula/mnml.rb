class Mnml < Formula
  desc "NvChad-style terminal IDE in Rust"
  homepage "https://mnml.sh"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-apple-darwin.tar.xz"
      sha256 "78b82dc5c39c688cd75e90bab14eb78541921a4a6726d4f7f65522f9619af6c6"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-apple-darwin.tar.xz"
      sha256 "e35242d5260ee509b224b4e68123981c47da0b6a5090716630f728c025182bbc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "333477a4f0271c994e70582134fe9e77817658663ad476907c135f7bd504c590"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8985ee98da07a818fe3574acb1ea2911a239a18e8b35f08086121a58dca92978"
    end
  end

  def install
    bin.install "mnml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mnml --version")
  end
end
