cask "nytuo-launcher" do
  arch arm: "aarch64", intel: "x64"

  version "4.1.0"
  sha256 arm:   "92732225b1fe3635a5890b013b13c5c7c9d67912d14a154e890d53eaca454c3c",
         intel: "acdc7b929942680893d17cfbc2ae2cd5b83e1b2e7f037f526fe0b4fb453453eb"

  url "https://github.com/Nytuo/Nytuo-Launcher/releases/download/v4.1.0/nytuo-launcher_#{version}_#{arch}.dmg"
  name "Nytuo Launcher"
  desc "Launcher that downloads, starts and updates games"
  homepage "https://github.com/Nytuo/Nytuo-Launcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "nytuo-launcher.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/nytuo-launcher.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.launcher",
    "~/Library/Caches/fr.nytuo.launcher",
    "~/Library/HTTPStorages/fr.nytuo.launcher",
    "~/Library/Preferences/fr.nytuo.launcher.plist",
    "~/Library/Saved Application State/fr.nytuo.launcher.savedState",
    "~/Library/WebKit/fr.nytuo.launcher",
  ]

  caveats do
    <<~EOS
      Nytuo Launcher is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      nytuo-launcher.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
