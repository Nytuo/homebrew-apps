cask "diapason" do
  version "0.12.0"
  sha256 "45655536a50802e20b41c3289d3ab76bd430d4a7aa4a80dbc50e3b9a0f43a2b3"

  url "https://github.com/Nytuo/diapason-flutter/releases/download/v0.12.0/diapason-#{version}_macos_aarch64.dmg"
  name "Diapason"
  desc "Local-first music player with full playback control"
  homepage "https://github.com/Nytuo/diapason-flutter"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Diapason.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Diapason.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.diapason",
    "~/Library/Caches/fr.nytuo.diapason",
    "~/Library/HTTPStorages/fr.nytuo.diapason",
    "~/Library/Preferences/fr.nytuo.diapason.plist",
    "~/Library/Saved Application State/fr.nytuo.diapason.savedState",
    "~/Library/WebKit/fr.nytuo.diapason",
  ]

  caveats do
    <<~EOS
      Diapason is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Diapason.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
