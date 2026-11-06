class AppsignalCli < Formula
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/appsignal-cli"
  version "2.2.2"

  on_macos do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 "91258c5549539c9caa5078cb87d70c62a873ae45f304a58a53495c9bd01a097a"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 "42bd400277f13a47671d46a6c240c7ba19e571c9fb02f7b86d0331e1443aebd7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 "95160e7f117319a2d19ba2b8ff83222560db56b2db3d3862ea03aafe47acc989"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 "446112b0080d093e3ba8e65d4431f4b7ac9ff4e080f21450003cf00db26f034e"
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
