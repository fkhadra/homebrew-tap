cask "git-pal" do
  arch arm: "aarch64", intel: "x64"

  version "0.0.4"
  sha256 arm:   "5d6aad2e88bbd00429b42d50d329f733ba9aecf6b9edddd9a72db974167e2d85",
         intel: "11d00fae9088d783ef7fbc0ff52a5d36fc86470f4908cae7ff7f1888593349a9"

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
