cask "cosmic-comics" do
  arch arm: "aarch64", intel: "x64"

  version "3.0.1"
  sha256 arm:   "1a31e3c9f32b7f56ee24f126180e8c49f99967d084665637eb00c21f2ce102cd",
         intel: "099e3d6914fe2b2d57d1dc76af7a8c66caf7727aa0855922ebe3c18687a3ca1c"

  url "https://github.com/Nytuo/CosmicComics/releases/download/v3.0.1/Cosmic.Comics_#{version}_#{arch}.dmg"
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
