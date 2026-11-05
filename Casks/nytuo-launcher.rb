cask "nytuo-launcher" do
  arch arm: "aarch64", intel: "x64"

  version "4.3.0"
  sha256 arm:   "ebc34a4e98d762d0a0ae2011d3525c4f9d32d7287cc4ef93b7359be1c3678347",
         intel: "ffaa437cec40692bfba1353da266a3048cbd2894bbf075d63852f031aef01ec0"

  url "https://github.com/Nytuo/Nytuo-Launcher/releases/download/v4.3.0/nytuo-launcher_#{version}_#{arch}.dmg"
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
