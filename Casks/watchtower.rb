cask "watchtower" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "56027f7599bff2351d622c81762fb65182a7aee9393678d817bffd775b865423",
         intel: "48c116482737ee720827531e015fa6015be6df4dcedc43e6c153965758bf0a47"

  url "https://github.com/Nytuo/watchtower/releases/download/v#{version}/Watchtower_#{version}_#{arch}.dmg"
  name "Watchtower"
  desc "Privacy-first SSH/SFTP/FTP desktop client"
  homepage "https://github.com/Nytuo/watchtower"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur

  app "Watchtower.app"

  zap trash: [
    "~/Library/Application Support/fr.nytuo.watchtower",
    "~/Library/Caches/fr.nytuo.watchtower",
    "~/Library/Preferences/fr.nytuo.watchtower.plist",
    "~/Library/Saved Application State/fr.nytuo.watchtower.savedState",
    "~/Library/WebKit/fr.nytuo.watchtower",
  ]

  caveats do
    <<~EOS
      Watchtower is not notarized by Apple. On first launch, macOS
      Gatekeeper will refuse to open it — right-click the app in Finder,
      choose "Open", then confirm in the dialog that appears.
    EOS
  end
end
