class Mnml < Formula
  desc "NvChad-style terminal IDE in Rust"
  homepage "https://mnml.sh"
  version "0.2.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-apple-darwin.tar.xz"
      sha256 "3bed83268e6156249f67740ee1ec5e31bea331c85fac9c061aa8ba6f73eeefc0"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-apple-darwin.tar.xz"
      sha256 "66b1e862f2dc1585984896cb429d39c0b2154389ed162d5271c624667cc0bfb3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "15075d5fef612f170e9dbd450b62852dad4d2e845a9c0eee66fb824d9d0a9ac6"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8cd39a9ed761e4b20a44557b2e8d3d8d79386d9dbb36735eeeee5296c84413d5"
    end
  end

  def install
    bin.install "mnml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mnml --version")
  end
end
