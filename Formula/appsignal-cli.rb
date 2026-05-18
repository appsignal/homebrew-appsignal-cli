class AppsignalCli < Formula
  desc 'CLI for interacting with AppSignal'
  homepage 'https://github.com/appsignal/homebrew-appsignal-cli'
  version '0.2.0'

  on_macos do
    on_arm do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 'adf513fc7a6cae9c11b9aa65788f2b98a6e80d89314179d22619cecbc4b9d4ae'
    end

    on_intel do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 '1ffeaeeca02e1d4f412609fc39e8b47c18a9be4da88c6581b55bcde1cfe57d4f'
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 'c6c9e513969d96eac1a05d30f8b08d2949eba16919e0d8243734b7b4f2001eb3'
    end

    on_intel do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 '39c3de317ea5d2def6a9ad08bfcfa49e44284bba678d9c6a1c8690da8110f2e9'
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install 'appsignal-cli'
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/appsignal-cli --version")
  end
end
