# homebrew-appsignal-cli

Public Homebrew tap for `appsignal-cli`.

This repository exists because the source repository for `appsignal-cli` is private, while Homebrew formulas must download from a public URL. The release workflow in this repository mirrors the release artifacts that Homebrew needs.

## Install

```sh
brew tap appsignal/appsignal-cli
brew install appsignal-cli
```

Or install the latest release directly with `curl`:

```sh
curl -fsSL https://raw.githubusercontent.com/appsignal/homebrew-appsignal-cli/main/install.sh | sh
```

Install a specific version:

```sh
curl -fsSL https://raw.githubusercontent.com/appsignal/homebrew-appsignal-cli/main/install.sh | VERSION=1.0.1 sh
```

Optional variables:

- `VERSION=1.0.1` installs a specific version.
- `INSTALL_DIR=$HOME/.local/bin` installs to a custom directory.

## Release flow

1. Publish `vX.Y.Z` in the private `appsignal/appsignal-cli` repository.
2. Run the `Mirror appsignal-cli release` workflow in this repository with `X.Y.Z`.
3. The workflow downloads the macOS and Linux GNU tarballs from the private release, publishes them to this public repository's matching release, and updates `Formula/appsignal-cli.rb` with the new version and SHA256 values.

The formula installs a prebuilt binary from this public repository's GitHub Releases instead of building from source during `brew install`.

## Required secret

- `SOURCE_REPO_TOKEN`: GitHub token with read access to `appsignal/appsignal-cli` releases.
