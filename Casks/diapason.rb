cask "diapason" do
  version "0.13.1"
  sha256 "19934f033073d3cfd6b67e964acd802e7b3c755f34dc404deb9fd42867bb7904"

  url "https://github.com/Nytuo/diapason-flutter/releases/download/v0.13.1/diapason-#{version}_macos_aarch64.dmg"
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
