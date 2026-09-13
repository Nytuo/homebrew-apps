cask "backupper" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.2"
  sha256 arm:   "846a9a712af383e4baf31445b69070b97ac0ae9a6de6c534ce1702d296a850d3",
         intel: "97e824cc313fbb803c9f9d77750ba3a42bc88dfc347abf46a8cf7f6ad7ea121c"

  url "https://github.com/Nytuo/Backupper/releases/download/v0.2.2/Backupper_#{version}_#{arch}.dmg"
  name "Backupper"
  desc "Secure and simple file backup"
  homepage "https://github.com/Nytuo/Backupper"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "Backupper.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Backupper.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.backupper",
    "~/Library/Caches/fr.nytuo.backupper",
    "~/Library/HTTPStorages/fr.nytuo.backupper",
    "~/Library/Preferences/fr.nytuo.backupper.plist",
    "~/Library/Saved Application State/fr.nytuo.backupper.savedState",
    "~/Library/WebKit/fr.nytuo.backupper",
  ]

  caveats do
    <<~EOS
      Backupper is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Backupper.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
