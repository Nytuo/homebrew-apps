cask "meteoric" do
  arch arm: "aarch64", intel: "x64"

  version "2.1.1"
  sha256 arm:   "4c34dc2e834d3d32d65d74d3d30e5dd139a7b6c0d7cc43b989c1267cb5f4bd40",
         intel: "682b94ba73c053feac84c22b34826500cfda6c078e1ee92e33ad8cf2e49d5b06"

  url "https://github.com/Nytuo/Meteoric/releases/download/v2.1.1/Meteoric_#{version}_#{arch}.dmg"
  name "Meteoric"
  desc "Video game library manager with a unified interface"
  homepage "https://github.com/Nytuo/Meteoric"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "Meteoric.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Meteoric.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.meteoric",
    "~/Library/Caches/fr.nytuo.meteoric",
    "~/Library/HTTPStorages/fr.nytuo.meteoric",
    "~/Library/Preferences/fr.nytuo.meteoric.plist",
    "~/Library/Saved Application State/fr.nytuo.meteoric.savedState",
    "~/Library/WebKit/fr.nytuo.meteoric",
  ]

  caveats do
    <<~EOS
      Meteoric is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Meteoric.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
