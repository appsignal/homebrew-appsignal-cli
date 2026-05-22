class AppsignalCli < Formula
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/homebrew-appsignal-cli"
  version "0.2.1"

  on_macos do
    on_arm do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 "e336ac23a7eac2173e04f598728fff96d8979912cf3d961bdfb063e5bc40de08"
    end

    on_intel do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 "144bf9478e9ab7b7e88d9817775147ae767a1490768afca648be209a2209c177"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03bd87aacb8606f9fd78187f8f20090d869c1915f61d235a67bbeb53bfc270cc"
    end

    on_intel do
      url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62dfe88cdc64deb8b1f9a137e37e35322c2b2b67dabf8c527d6dd2e92223d8cc"
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
