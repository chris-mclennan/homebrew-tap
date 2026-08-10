class Mnml < Formula
  desc "NvChad-style terminal IDE in Rust"
  homepage "https://mnml.sh"
  version "0.2.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-apple-darwin.tar.xz"
      sha256 "1502cb8709a634c2aca68cf0b793a920eed1adef7aecd2186d444ac78bd6430f"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-apple-darwin.tar.xz"
      sha256 "1cd6a6c7a4367e5b70ecf92162bf533cde7911ce21259a3171738dd116918dee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "27e5b298e222554727c3f9d3929feecd8220ffc38cc69feac5462e52e6e21462"
    else
      url "https://github.com/chris-mclennan/mnml/releases/download/v#{version}/mnml-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7804e34bdb57f53f8096807013551d6965fbafc1e1bf963b378de7b0dfbcbb6d"
    end
  end

  def install
    bin.install "mnml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mnml --version")
  end
end
