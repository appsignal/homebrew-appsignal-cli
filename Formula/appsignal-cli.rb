class AppsignalCli < Formula
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/appsignal-cli"
  version "2.0.2"

  on_macos do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 "15dfc1d13a548ace8b65c3de6c9ba65dd2f31710aaf6caaf3adaa34324d3b810"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 "94d90693f2ed36b7625da65972cef680eb2b6283d8d6cdb416a755205d6239e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ca9c46acf57a9fbe3bc3d9381f4a81e20672489dd3f22c140cd24b1f95b883a1"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e9eae3e948200bc63c62fb78da9ef5807fa5148548efc458cf937f511aa2d319"
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
