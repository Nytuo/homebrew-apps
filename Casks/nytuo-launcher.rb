cask "nytuo-launcher" do
  arch arm: "aarch64", intel: "x64"

  version "4.2.0"
  sha256 arm:   "1f99c2f598af37c1c0fb9dbbab1bb19ed60a5b978246fc0e8dd6294e8e834c8e",
         intel: "b7e42b441a86258957896272c27dbc860832ac9df9998da6df5a68ba514187fc"

  url "https://github.com/Nytuo/Nytuo-Launcher/releases/download/v4.2.0/nytuo-launcher_#{version}_#{arch}.dmg"
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
