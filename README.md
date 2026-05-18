# homebrew-appsignal-cli

Public Homebrew tap for `appsignal-cli`.

This repository exists because the source repository for `appsignal-cli` is private, while Homebrew casks must download from a public URL. The release workflow in this repository mirrors the macOS release artifacts that Homebrew needs.

## Install

```sh
brew tap appsignal/appsignal-cli
brew install --cask appsignal-cli
```

## Release flow

1. Publish `vX.Y.Z` in the private `appsignal/appsignal-cli` repository.
2. Run the `Mirror appsignal-cli release` workflow in this repository with `X.Y.Z`.
3. The workflow downloads the macOS tarballs from the private release, publishes them to this public repository's matching release, and updates `Casks/appsignal-cli.rb` with the new version and SHA256 values.

Only macOS artifacts are mirrored here because Homebrew casks are macOS-only. Linux installs should continue to use the release artifacts from the source repository.

## Required secret

- `SOURCE_REPO_TOKEN`: GitHub token with read access to `appsignal/appsignal-cli` releases.
