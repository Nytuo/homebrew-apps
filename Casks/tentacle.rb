cask "tentacle" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "45044a18589a3e3516e0fbb328557d490bf9d8c30c584bc9709366503e39b1cb",
         intel: "1c1e38a64e6e754b0617790889e5b49046ee75e32568b8ba53b50a33f9f4fa09"

  url "https://github.com/Nytuo/tentacle/releases/download/v#{version}/Tentacle_#{version}_#{arch}.dmg"
  name "Tentacle"
  desc "Privacy-first Git client"
  homepage "https://github.com/Nytuo/tentacle"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "Tentacle.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tentacle.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.tentacle",
    "~/Library/Caches/fr.nytuo.tentacle",
    "~/Library/HTTPStorages/fr.nytuo.tentacle",
    "~/Library/Preferences/fr.nytuo.tentacle.plist",
    "~/Library/Saved Application State/fr.nytuo.tentacle.savedState",
    "~/Library/WebKit/fr.nytuo.tentacle",
  ]

  caveats do
    <<~EOS
      Tentacle is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Tentacle.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
