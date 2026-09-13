cask "arbor" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.1"
  sha256 arm:   "816e3fca8eb0dc08fdc6060fde5a9386a084b269b42842263fbf65b9342c1649",
         intel: "517d072f75177ec995714e0722a84c2c55c5fce6ba8aa9c7123c4120c19c288c"

  url "https://github.com/Nytuo/arbor/releases/download/v0.2.1/Arbor_#{version}_#{arch}.dmg"
  name "Arbor"
  desc "Genealogy app for building family trees"
  homepage "https://github.com/Nytuo/arbor"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "Arbor.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Arbor.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.nytuo.arbor",
    "~/Library/Caches/com.nytuo.arbor",
    "~/Library/HTTPStorages/com.nytuo.arbor",
    "~/Library/Preferences/com.nytuo.arbor.plist",
    "~/Library/Saved Application State/com.nytuo.arbor.savedState",
    "~/Library/WebKit/com.nytuo.arbor",
  ]

  caveats do
    <<~EOS
      Arbor is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Arbor.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
