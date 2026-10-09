cask "git-pal" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.1"
  sha256 arm:   "1f5b23ee65f1338535ce3ee1b9fb542b2c036b64ec694528aaebd6a3371ee28b",
         intel: "9dbe750e9b21d1e44334db11aa747a7ed828b9fbcc2caac4529310c330b42451"

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
