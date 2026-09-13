cask "meteoric" do
  arch arm: "aarch64", intel: "x64"

  version "2.1.0"
  sha256 arm:   "2fa69e9ce54552c098d3a22b1be216bd221e16883b18298a531b4e8d6253c6a7",
         intel: "66f6f95d53be505edd948bd573c7462e7316bd26c4b552d9369fdc08d384280d"

  url "https://github.com/Nytuo/Meteoric/releases/download/meteoric-v#{version}/Meteoric_#{version}_#{arch}.dmg"
  name "Meteoric"
  desc "Video game library manager with a unified interface"
  homepage "https://github.com/Nytuo/Meteoric"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "Meteoric.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Meteoric.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.meteoric",
    "~/Library/Caches/fr.nytuo.meteoric",
    "~/Library/HTTPStorages/fr.nytuo.meteoric",
    "~/Library/Preferences/fr.nytuo.meteoric.plist",
    "~/Library/Saved Application State/fr.nytuo.meteoric.savedState",
    "~/Library/WebKit/fr.nytuo.meteoric",
  ]

  caveats do
    <<~EOS
      Meteoric is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Meteoric.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
