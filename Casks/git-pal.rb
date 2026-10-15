cask "git-pal" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.3"
  sha256 arm:   "26697ab2a5451e26f033194d45d0528bdc5278cb624432eb2be1c128d1e7305b",
         intel: "3f1d3d9c37ef2218cf39bdfa840b033036ec7071f5d62889c8951e5dbf8030e2"

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
