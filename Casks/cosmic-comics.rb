cask "cosmic-comics" do
  arch arm: "aarch64", intel: "x64"

  version "3.0.0"
  sha256 arm:   "d57410a742bc5d936bd8bad9ac4e0e1f80b4b26384a94a25e7a96b68606591dc",
         intel: "4513b8ded45dea23f1043d7c71c18e971998664e10f3bf8a5ee367f70be5c9d4"

  url "https://github.com/Nytuo/CosmicComics/releases/download/v#{version}/Cosmic.Comics_#{version}_#{arch}.dmg"
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
