cask "bryllun" do
  arch arm: "aarch64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "967dba6c459ba67f19a6afaeccb71c7324e7368121d54d6862b64a4477db6662",
         intel: "e204e70776609a1293613e292c9902ff767259f1eed1441fafcb17098b64788f"

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
