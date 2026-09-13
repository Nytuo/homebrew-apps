cask "nytuo-launcher" do
  arch arm: "aarch64", intel: "x64"

  version "4.0.1"
  sha256 arm:   "feaf34fa538d1a0a0ebb56e4c5149a4be45491b2b04070210e9daa72f0892a48",
         intel: "f07018fb6c352f590cf20ab1b702c62426fdcff45693a0da8cb6a2d055b8e1a9"

  url "https://github.com/Nytuo/Nytuo-Launcher/releases/download/nytuolauncher-v#{version}/nytuo-launcher_#{version}_#{arch}.dmg"
  name "Nytuo Launcher"
  desc "Launcher that downloads, starts and updates games"
  homepage "https://github.com/Nytuo/Nytuo-Launcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "nytuo-launcher.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/nytuo-launcher.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.launcher",
    "~/Library/Caches/fr.nytuo.launcher",
    "~/Library/HTTPStorages/fr.nytuo.launcher",
    "~/Library/Preferences/fr.nytuo.launcher.plist",
    "~/Library/Saved Application State/fr.nytuo.launcher.savedState",
    "~/Library/WebKit/fr.nytuo.launcher",
  ]

  caveats do
    <<~EOS
      Nytuo Launcher is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      nytuo-launcher.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
