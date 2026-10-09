cask "notata" do
  version "0.3.0"
  sha256 "0bbe0ec9b5d59779cfdaafef45f68a2babb432807b62872a0815eb38145e1cc2"

  url "https://github.com/Nytuo/Notata/releases/download/v0.3.0/Notata_#{version}_aarch64.dmg"
  name "Notata"
  desc "Tags media once so every server can read it"
  homepage "https://github.com/Nytuo/Notata"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Notata.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Notata.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.notata",
    "~/Library/Caches/fr.nytuo.notata",
    "~/Library/HTTPStorages/fr.nytuo.notata",
    "~/Library/Preferences/fr.nytuo.notata.plist",
    "~/Library/Saved Application State/fr.nytuo.notata.savedState",
    "~/Library/WebKit/fr.nytuo.notata",
  ]

  caveats do
    <<~EOS
      Notata is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Notata.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
