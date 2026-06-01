cask "tmnl" do
  version "0.0.4"

  on_arm do
    sha256 "e942f90f305382d6dcbfc0d695e20282342c60a98f68a22fbd45a1823f326999"
    url "https://github.com/chris-mclennan/tmnl/releases/download/v#{version}/tmnl-rs-aarch64-apple-darwin.dmg"
  end

  on_intel do
    sha256 "8ab4a90e5c2497b5f1e04860fd2c03ab4beb530eaccdae3d64b245674231d03e"
    url "https://github.com/chris-mclennan/tmnl/releases/download/v#{version}/tmnl-rs-x86_64-apple-darwin.dmg"
  end

  name "tmnl"
  desc "GPU-rendered terminal with a structured-cell display protocol"
  homepage "https://tmnl.sh"

  app "tmnl.app"

  zap trash: [
    "~/.config/tmnl",
    "~/Library/Application Support/sh.tmnl",
    "~/Library/Caches/sh.tmnl",
    "~/Library/Preferences/sh.tmnl.plist",
  ]
end
