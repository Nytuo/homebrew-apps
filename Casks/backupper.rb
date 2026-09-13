cask "backupper" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.1"
  sha256 arm:   "828a69234f96182c861c0d7fd280f341a43cc7ef5e5d1b8d941a9b844ed78522",
         intel: "1cfa928aa96e696c62a191994a2f7fc0831da73de05accf513f3156fc237de26"

  url "https://github.com/Nytuo/Backupper/releases/download/backupper-v#{version}/Backupper_#{version}_#{arch}.dmg"
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
