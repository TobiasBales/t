#!/usr/bin/env bash

set -euo pipefail

echo "Enforcing macos settings"
# auto hide dock, quickly
defaults write com.apple.dock autohide -int 1
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
# smaller dock icons
defaults write com.apple.dock tilesize -int 36
# disable recent applications in dock
defaults write com.apple.dock show-recents -int 0
killall Dock

# show battery percentage in menubar
defaults write com.apple.menuextra.battery ShowPercent YES
killall SystemUIServer

# increase window resize speed
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# show expanded save dialog by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
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
# enable subpixel font rendering on non apple lcds
defaults write NSGlobalDomain AppleFontSmoothing -int 2
# enable text selection in preview/quick look
defaults write com.apple.finder QLEnableTextSelection -bool true
# use posix path for finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# don't create .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# speed up mission control and group windows by app
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

# enable debug menu in diskutil
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
# don't let timemachine prompt for new volumes
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

