cask "watchtower" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "81eae73461e44d347c115045b06886a468d7f1e4ea4ab25cf111f978f25e77ea",
         intel: "0d172b0652880980bc1627096b554bac6747ac685c1f78f9f46fe8108fc03b9f"

  url "https://github.com/Nytuo/watchtower/releases/download/v0.2.0/Watchtower_#{version}_#{arch}.dmg"
  name "Watchtower"
  desc "Privacy-first SSH/SFTP/FTP desktop client"
  homepage "https://github.com/Nytuo/watchtower"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "Watchtower.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Watchtower.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.watchtower",
    "~/Library/Caches/fr.nytuo.watchtower",
    "~/Library/HTTPStorages/fr.nytuo.watchtower",
    "~/Library/Preferences/fr.nytuo.watchtower.plist",
    "~/Library/Saved Application State/fr.nytuo.watchtower.savedState",
    "~/Library/WebKit/fr.nytuo.watchtower",
  ]

  caveats do
    <<~EOS
      Watchtower is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Watchtower.app in from elsewhere (not via brew), you'll need to
      right-click it in Finder and choose "Open" instead.
    EOS
  end
end
