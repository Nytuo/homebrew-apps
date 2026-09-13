cask "arbor" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "ed7a5136082cdfb29f0f98ee911837aeacff3e9be154f6e4245613d2594cc7ba",
         intel: "501c5458bafea7356cf8f85d500b3226fa0c8eb4e48193db90da19be0b943950"

  url "https://github.com/Nytuo/arbor/releases/download/arbor-v#{version}/Arbor_#{version}_#{arch}.dmg"
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
