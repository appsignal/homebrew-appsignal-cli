class AppsignalCli < Formula
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/appsignal-cli"
  version "2.0.1"

  on_macos do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 "12c4bf9d08455b5f59c7f6ae94ef11e1079a0a96bd6b0ea180b641213cc5619a"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 "170f29068e12053cab4ab0e3f48da5d231a1b9f0ec187ee6711c456ea49ef4b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 "46679c3676af070004a8b63503afd874970a4dd7a95c5745c05d7e7dac9c446d"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 "34bc518ee2cf50ecfefed98ecb089340ebe1c82c67a5681a0ae5e8df49b4fc7e"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "appsignal-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/appsignal-cli --version")
  end
end
