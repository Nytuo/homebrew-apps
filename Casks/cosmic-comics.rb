cask "cosmic-comics" do
  arch arm: "aarch64", intel: "x64"

  version "3.2.0"
  sha256 arm:   "8c24ffd324f1f6bb8d73ee5557c2b19c79fdaff40ed58bc28a1c6bc5ac6b449c",
         intel: "128336705e066b075e12a2b2e27c62c9c742e2867d3bc02f0d0ef4da93675139"

  url "https://github.com/Nytuo/CosmicComics/releases/download/v3.2.0/Cosmic.Comics_#{version}_#{arch}.dmg"
  name "Cosmic Comics"
  desc "Reader for comics, manga and ebooks"
  homepage "https://github.com/Nytuo/CosmicComics"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "Cosmic Comics.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Cosmic Comics.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.cosmiccomics",
    "~/Library/Caches/fr.nytuo.cosmiccomics",
    "~/Library/HTTPStorages/fr.nytuo.cosmiccomics",
    "~/Library/Preferences/fr.nytuo.cosmiccomics.plist",
    "~/Library/Saved Application State/fr.nytuo.cosmiccomics.savedState",
    "~/Library/WebKit/fr.nytuo.cosmiccomics",
  ]

  caveats do
    <<~EOS
      Cosmic Comics is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Cosmic Comics.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
