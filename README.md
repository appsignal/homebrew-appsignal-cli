# homebrew-appsignal-cli

Homebrew tap for [`appsignal-cli`](https://github.com/appsignal/appsignal-cli).

## Install

```sh
brew install appsignal/appsignal-cli/appsignal-cli
```

Homebrew automatically taps `appsignal/appsignal-cli` when using the full formula name above. You can also tap it explicitly:

```sh
brew tap appsignal/appsignal-cli
brew install appsignal-cli
```

## Updating

Homebrew installs the version committed in `Formula/appsignal-cli.rb`. To update an installed copy after this tap is updated:

```sh
brew update
brew upgrade appsignal-cli
```

## Install Script

The standalone installer is maintained in the `appsignal-cli` repository and published with each release:

```sh
curl -sSL https://github.com/appsignal/appsignal-cli/releases/latest/download/install.sh | sudo sh
```

## Release Flow

1. Publish `vX.Y.Z` in [`appsignal/appsignal-cli`](https://github.com/appsignal/appsignal-cli).
2. Run the `Update appsignal-cli formula` workflow in this repository with `X.Y.Z`.
3. The workflow downloads `SHA256SUMS` from the public CLI release and commits an updated `Formula/appsignal-cli.rb`.

This tap does not mirror release artifacts. The formula installs prebuilt binaries directly from `appsignal/appsignal-cli` GitHub Releases.
