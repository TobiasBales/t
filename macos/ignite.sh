#!/usr/bin/env bash

set -euo pipefail

CONFIG_PATH=$(dirname "${0}")
LAST_RUN_FILE="${CONFIG_PATH}/.last_run_macos_settings"
if ! [ -f "${LAST_RUN_FILE}" ]; then
  date +%s > "${LAST_RUN_FILE}"
fi
LAST_RUN=$(cat "${LAST_RUN_FILE}")
LAST_CHANGE=$(stat -f "%m" "${0}")

if [[ "${LAST_CHANGE}" -le ${LAST_RUN} ]]; then
  exit 0
fi
date +%s > "${LAST_RUN_FILE}"

echo "Enforcing macos settings"
# auto hide dock, quickly
defaults write com.apple.dock autohide -int 1
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true
# smaller dock icons
defaults write com.apple.dock tilesize -int 36
# disable recent applications in dock
defaults write com.apple.dock show-recents -int 0
# Disable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0
killall Dock

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5
# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0
# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# show battery percentage in menubar
defaults write com.apple.menuextra.battery ShowPercent YES
killall SystemUIServer

SYSTEM_VOLUME=$(nvram SystemAudioVolume)
if [ "${SYSTEM_VOLUME}" != "SystemAudioVolume	 " ]; then
  echo "Disabling startup sounds, needs sudo"
  sudo nvram SystemAudioVolume=" "
fi


# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# increase window resize speed
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# Disable the over-the-top focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false
# show expanded save dialog by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# show expanded print dialog by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable resume applications system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true
# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Berlin" > /dev/null
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# disable "are you sure you want to open this file?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# disable automatic termination of apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
# increase bluetooth sound quality
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
# allow full keyboard access, e.g. tab in modals
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# disable auto correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# require password immediatelly after sleep/screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# save screenshots to the desktop per default
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"
# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true
# enable subpixel font rendering on non apple lcds
defaults write NSGlobalDomain AppleFontSmoothing -int 2
# enable text selection in preview/quick look
defaults write com.apple.finder QLEnableTextSelection -bool true
# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true
# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# use posix path for finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# don't create .DS_Store files on network volumes and usb devices
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true
# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true
# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true
# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true
# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false
# speed up mission control and group windows by app
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true
# enable debug menu in diskutil
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
# don't let timemachine prompt for new volumes
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true
# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

