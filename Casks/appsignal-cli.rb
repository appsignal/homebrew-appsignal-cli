cask 'appsignal-cli' do
  arch arm: 'aarch64', intel: 'x86_64'

  version '0.1.0'
  sha256 arm: 'bcfddac21adfefe0b32c6e7966c344567983c8f580dae5fa9995c1d7a4043da7',
         intel: '24ae3999bd7d009b7066d441cce7b6266e73e283028e7c16dc185feaf80c076a'

  url "https://github.com/appsignal/homebrew-appsignal-cli/releases/download/v#{version}/#{arch}-apple-darwin.tar.gz",
      verified: 'github.com/appsignal/homebrew-appsignal-cli/'
  name 'appsignal-cli'
  desc 'CLI for interacting with AppSignal'
  homepage 'https://github.com/appsignal/homebrew-appsignal-cli'

  livecheck do
    url :url
    strategy :github_latest
  end

  binary 'appsignal-cli'
end
