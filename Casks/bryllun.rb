cask "bryllun" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.6"
  sha256 arm:   "66f631252e43b18fdf4684b299e1f0bb88858daf464e38c63d5fcc5abaff215b",
         intel: "20d9f315c0af7c27b5526d61f16f741c022c1f1c20d16db929c50216403f776c"

  url "https://github.com/md2perpe/bryllun/releases/download/v#{version}/Bryllun_#{version}_#{arch}.dmg"
  name "Bryllun"
  desc "Desktop client for SNMP, gNMI, and NETCONF devices"
  homepage "https://github.com/md2perpe/bryllun"

  depends_on :macos

  app "Bryllun.app"

  # The app isn't code-signed/notarized (no paid Apple Developer account),
  # so macOS Gatekeeper would otherwise report it as "damaged". Strip the
  # quarantine attribute right after install so it opens normally.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Bryllun.app"]
  end

  zap trash: [
    "~/Library/Application Support/sh.perpe.bryllun",
    "~/Library/Caches/sh.perpe.bryllun",
    "~/Library/Preferences/sh.perpe.bryllun.plist",
    "~/Library/Saved Application State/sh.perpe.bryllun.savedState",
  ]
end
