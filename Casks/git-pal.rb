cask "git-pal" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.5"
  sha256 arm:   "d68c06a26cfc02746b22bb7813f1548d7002ad131a8ffe5114cd62f157f9ffcc",
         intel: "9230618caf415c6f2e5d0643360ab05a7fde8fb0cba02a0a845eebc25090bf43"

  url "https://github.com/fkhadra/git-pal/releases/download/v#{version}/Git.Pal_#{version}_#{arch}.dmg"
  name "Git Pal"
  desc "Keyboard-first companion for GitHub pull requests with AI reviews"
  homepage "https://github.com/fkhadra/git-pal"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on :macos

  app "Git Pal.app"

  zap trash: [
    "~/.config/git-pal",
    "~/Library/Caches/com.gugu.git-pal",
    "~/Library/Logs/com.gugu.git-pal",
    "~/Library/Preferences/com.gugu.git-pal.plist",
    "~/Library/WebKit/com.gugu.git-pal",
  ]
end
