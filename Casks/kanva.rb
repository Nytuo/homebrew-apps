cask "kanva" do
  version "0.1.0"
  sha256 "79b8e6ebdab78cca29bd21ec7eed1d0a4b18e2b65eeba506744cbd16daa49a35"

  url "https://github.com/Nytuo/Kanva/releases/download/v#{version}/Kanva_#{version}_aarch64.dmg"
  name "Kanva"
  desc "Self-hostable Kanban boards with notes and calendar"
  homepage "https://github.com/Nytuo/Kanva"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Kanva.app"

  # The app is not notarized, so Gatekeeper would otherwise refuse to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Kanva.app"]
  end

  zap trash: [
    "~/Library/Application Support/fr.nytuo.kanva",
    "~/Library/Caches/fr.nytuo.kanva",
    "~/Library/HTTPStorages/fr.nytuo.kanva",
    "~/Library/Preferences/fr.nytuo.kanva.plist",
    "~/Library/Saved Application State/fr.nytuo.kanva.savedState",
    "~/Library/WebKit/fr.nytuo.kanva",
  ]

  caveats do
    <<~EOS
      Kanva is not notarized by Apple. This cask removes the quarantine
      attribute after install, so Gatekeeper won't prompt. If you ever copy
      Kanva.app in from elsewhere (not via brew), you'll need to right-click it
      in Finder and choose "Open" instead.
    EOS
  end
end
