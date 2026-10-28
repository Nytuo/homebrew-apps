cask "tentacle" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "43ed279579a179ac6848325c158c3323715a7161264483418b77f8ff3e15f555",
         intel: "e4cf1e8ab14eac9f6c7be3b9ff23efd8c22974a0602e67b1fce8b82cce74bd0d"

  url "https://github.com/Nytuo/tentacle/releases/download/v0.3.0/Tentacle_#{version}_#{arch}.dmg"
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
