class AppsignalCli < Formula
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/homebrew-appsignal-cli"
  version "1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 "68835c55df4af8625c3349b4f000802215ee07e06ccdf0934ab7904aaca34c55"
    end

    on_intel do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 "f04297b56ac6a160fe8f05bd4fa9381663ef430fc98828aec1074028e80aa592"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dfa61d13a4f5b5dc3e9397d191976f4ef8353070c9eac40bec9fea37ad40625d"
    end

    on_intel do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 "21e1920f47787532ff82d122f74cb86d1e1094d6c338bde1177dbd2b0b3fc815"
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
