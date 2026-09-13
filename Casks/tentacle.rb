cask "tentacle" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.1"
  sha256 arm:   "8d02254d60ffbd2b52531388232ac6af5917b1c64bb840e87bb084c978c4590c",
         intel: "90183c9fe359bbf7c22763268a9946125e35b351ef460b6fa6f4332a37947ced"

  url "https://github.com/Nytuo/tentacle/releases/download/v0.2.1/Tentacle_#{version}_#{arch}.dmg"
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
