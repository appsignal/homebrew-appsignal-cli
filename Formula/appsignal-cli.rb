class AppsignalCli < Formula
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/homebrew-appsignal-cli"
  version "1.0.1"

  on_macos do
    on_arm do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 "bbc51227b5cd4271a96ffeb09d654319037fa347745452d3cafb8c54f20d4998"
    end

    on_intel do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 "267e61ecd42412e004cda814291402580f8540e46ba7acdbbfe18412cdf4ca01"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bb605bfde75c5dbf75d4fd14899d320897f80dc5c3dbbe0c75c84f20fa0a2d5a"
    end

    on_intel do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 "37e12d30a8c1d5e131e4b06bd5f3901a60328015ad48fa9354cc473a17294d59"
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
