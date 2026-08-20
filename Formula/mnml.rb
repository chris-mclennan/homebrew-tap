class Mnml < Formula
  desc "NvChad-style terminal IDE in Rust"
  homepage "https://mnml.sh"
  version "0.2.13"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-apple-darwin.tar.xz"
      sha256 "2c0513888f0c97773b7b2dc76beba9c25f9f7fde8eccc81bc074379c47d70db7"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-apple-darwin.tar.xz"
      sha256 "5ee5ce823f917affd2e4538544d4bde4767fc025c1a90e1187e0f2e59b17cfbb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "35d034b60b59fea5dc888c1b6ecb166edc338af5dac7c1a269ba80afc503e543"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3b38b47897e3cdd9fdf63fdb36ddfa4d5e830013f5006dc5d08979d0dc3de997"
    end
  end

  def install
    bin.install "mnml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mnml --version")
  end
end
