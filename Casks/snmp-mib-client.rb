cask "snmp-mib-client" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.4"
  sha256 arm:   "ccea9d6cab2953b31daea1fd8f01e94f98d156f1f3103103f5ee20282d266294",
         intel: "e2271345768c3fe4497bb37d3e1c5d702a48cf4d3dc8c2bbd0bece9714c510bb"

  url "https://github.com/md2perpe/snmp-browser/releases/download/v#{version}/SNMP.MIB.Client_#{version}_#{arch}.dmg"
  name "SNMP MIB Client"
  desc "GUI client for browsing and querying SNMP devices using MIB files"
  homepage "https://github.com/md2perpe/snmp-browser"

  depends_on :macos

  app "SNMP MIB Client.app"

  # The app isn't code-signed/notarized (no paid Apple Developer account),
  # so macOS Gatekeeper would otherwise report it as "damaged". Strip the
  # quarantine attribute right after install so it opens normally.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/SNMP MIB Client.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/sh.perpe.snmp-mib-client",
    "~/Library/Caches/sh.perpe.snmp-mib-client",
    "~/Library/Preferences/sh.perpe.snmp-mib-client.plist",
    "~/Library/Saved Application State/sh.perpe.snmp-mib-client.savedState",
  ]
end
