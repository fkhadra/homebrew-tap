cask "git-pal" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.2"
  sha256 arm:   "97f328d36caaebf956d4b836a610744c53ba2946fe477ca6ca70b64d7b6afe78",
         intel: "36ba838d48bfeb23d91db5fa067a2a89f291ea2a0f624e72feadae8e5d576f63"

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
