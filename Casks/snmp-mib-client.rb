cask "snmp-mib-client" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.5"
  sha256 arm:   "df0d7864ed3b93ff3d3194760dae14eda2dc02a89bee093ec76b05a515ddf8d1",
         intel: "8cc29cff17ac140c538638686eb2444d372d71b4714b8a5d9a098d74cf89bbd3"

  url "https://github.com/md2perpe/snmp-browser/releases/download/v#{version}/SNMP.MIB.Client_#{version}_#{arch}.dmg"
  name "SNMP MIB Client"
  desc "GUI client for browsing and querying SNMP devices using MIB files"
  homepage "https://github.com/md2perpe/snmp-browser"

  depends_on :macos

  app "SNMP MIB Client.app"

  # The app isn't code-signed/notarized (no paid Apple Developer account),
  # so macOS Gatekeeper would otherwise report it as "damaged". Strip the
  # quarantine attribute right after install so it opens normally.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/SNMP MIB Client.app"]
  end

  zap trash: [
    "~/Library/Application Support/sh.perpe.snmp-mib-client",
    "~/Library/Caches/sh.perpe.snmp-mib-client",
    "~/Library/Preferences/sh.perpe.snmp-mib-client.plist",
    "~/Library/Saved Application State/sh.perpe.snmp-mib-client.savedState",
  ]
end
