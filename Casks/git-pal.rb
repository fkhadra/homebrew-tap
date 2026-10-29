cask "git-pal" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.6"
  sha256 arm:   "15fe37732fce3575b8ac89d56cbd23e394f6397ccaa5d4c83ed8bcb112fd4caf",
         intel: "87ebd4d9a741e313a6315a4d1a5a48ec8e1af1ca0779ddb6a52f1ac4f6f0718f"

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
