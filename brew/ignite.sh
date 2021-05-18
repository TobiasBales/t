#!/usr/bin/env bash

set -euo pipefail

if ! command -v brew &> /dev/null; then
  echo "Homebrew not found, installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating homebrew"
brew tap filippo.io/yubikey-agent https://filippo.io/yubikey-agent
brew tap heroku/brew
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew update
brew upgrade

echo "Installing homebrew packages"
BREW_PACKAGES=(
  "8bitdo-firmware-updater"
  "8bitdo-ultimate-software"
  "Arkweid/lefthook/lefthook"
  "act"
  "alacritty"
  "anki"
  "audio-hijack"
  "autoconf"
  "awscli"
  "bat"
  "coreutils"
  "diff-so-fancy"
  "docker-compose"
  "elgato-control-center"
  "elgato-stream-deck"
  "enpass"
  "exa"
  "farrago"
  "ffmpeg"
  "fission"
  "focusrite-control"
  "font-jetbrains-mono-nerd-font"
  "fzf"
  "gawk"
  "gh"
  "git"
  "git-interactive-rebase-tool"
  "git-trim"
  "gnu-sed"
  "gnuplot"
  "google-chrome"
  "gpg"
  "grep"
  "guitar-pro"
  "heroku"
  "homebrew/cask/docker"
  "httpie"
  "imagemagick"
  "intellij-idea"
  "jetbrains-toolbox"
  "loopback"
  "mediainfo"
  "neovim"
  "node_exporter"
  "obs"
  "openemu"
  "openscad"
  "openssh"
  "overmind"
  "plex"
  "plexamp"
  "prusaslicer"
  "pwgen"
  "qfinder-pro"
  "qmk-toolbox"
  "qmk/qmk/qmk"
  "qsync-client"
  "raspberry-pi-imager"
  "raycast"
  "reaper"
  "ripgrep"
  "shellcheck"
  "softprops/tools/git-codeowners"
  "soundsource"
  "spotify"
  "starship"
  "the-unarchiver"
  "tldr"
  "tmux"
  "tree"
  "up"
  "vim"
  "visual-studio-code"
  "wxmac"
  "yubikey-agent"
  "zsh"
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
)
brew install "${BREW_PACKAGES[@]}"
brew services start yubikey-agent
brew services start node_exporter
