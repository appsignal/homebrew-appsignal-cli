class AppsignalCli < Formula
  desc "CLI for interacting with AppSignal"
  homepage "https://github.com/appsignal/appsignal-cli"
  version "2.2.1"

  on_macos do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-apple-darwin.tar.gz"
      sha256 "644bce332c46961ccd7e3f32e5dfaedbf3fd25afe392b9e26edb127f7716cc19"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-apple-darwin.tar.gz"
      sha256 "48cabcde03e99d352544e6106957136f5b7a276e08af18e4b4001b946e7641cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e66e6132b5f1af99d69cd4b6f729882daa4886b005b5d24f68f7440e6292a081"
    end

    on_intel do
      url "https://github.com/appsignal/appsignal-cli/releases/download/v#{version}/x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7119422defc508bf2275a3e374967ec6b002dca6854897574163ec1a97ae1c2c"
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
