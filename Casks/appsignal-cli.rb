cask "appsignal-cli" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.0"
  sha256 arm: "adf513fc7a6cae9c11b9aa65788f2b98a6e80d89314179d22619cecbc4b9d4ae",
         intel: "1ffeaeeca02e1d4f412609fc39e8b47c18a9be4da88c6581b55bcde1cfe57d4f"

  url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/#{arch}-apple-darwin.tar.gz",
      verified: "github.com/appsignal/homebrew-appsignal-cli/"
  name "appsignal-cli"
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/homebrew-appsignal-cli"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "appsignal-cli"
end
