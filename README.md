# chris-mclennan/homebrew-tap

Homebrew tap for the **mnml family** of terminal apps:

- [**mnml**](https://mnml.sh) — NvChad-style terminal IDE in Rust (formula)
- [**mixr**](https://mixr.sh) — Lean terminal DJ app for electronic music (formula)
- [**tmnl**](https://tmnl.sh) — GPU-rendered terminal (cask)

## Install

```sh
brew install chris-mclennan/tap/mnml
brew install chris-mclennan/tap/mixr
brew install --cask chris-mclennan/tap/tmnl
```

Tap once, install many:

```sh
brew tap chris-mclennan/tap
brew install mnml mixr
brew install --cask tmnl
```

## Updates

Each app's release CI bumps the formula/cask version + SHA256 in this tap after a successful release. Run `brew upgrade` to pull the latest.

## License

Each formula/cask is MIT-licensed (matching the upstream projects). This tap's metadata is MIT-licensed.
