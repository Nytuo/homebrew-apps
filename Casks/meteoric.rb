cask "meteoric" do
  arch arm: "aarch64", intel: "x64"

  version "2.2.0"
  sha256 arm:   "3a3ae04983c0e21e8f5a07c7eae20c0e468f56b71985b1d9b0d7febc92b84421",
         intel: "4806a31e1bf805bd849bfbbd0f557d2a9bc1ff020a154b7c8a19471be195f956"

  url "https://github.com/Nytuo/Meteoric/releases/download/v2.2.0/Meteoric_#{version}_#{arch}.dmg"
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
