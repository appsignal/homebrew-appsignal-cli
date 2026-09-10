class AppsignalCli < Formula
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/appsignal-cli"
  version "2.2.0"

  on_macos do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 "542cd4e82d6293c854b8cad56cbb0109fd8f333f1a545a978852892e7d4bd596"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 "dbf9ba8444c7d406cf4dfdc4238ccc1dd3bd5bc2f6f0ec56706dfca38b44b943"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f3ae53d2c58a6d28d3b631470824cd8697e84b35efb706c82f7015bf09a512fd"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1beabc22f381118c1770033069742953cd2b58ccb27d7268847aebb3b953579f"
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
