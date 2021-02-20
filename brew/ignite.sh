#!/usr/bin/env bash

set -euo pipefail

if ! command -v brew &> /dev/null; then
  echo "Homebrew not found, installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating homebrew"
brew tap filippo.io/yubikey-agent https://filippo.io/yubikey-agent
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew update
brew upgrade

echo "Installing homebrew packages"
BREW_PACKAGES=(
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
  "google-chrome"
  "gpg"
  "grep"
  "guitar-pro"
  "homebrew/cask/docker"
  "httpie"
  "imagemagick"
  "intellij-idea"
  "loopback"
  "mediainfo"
  "neovim"
  "obs"
  "prusaslicer"
  "qfinder-pro"
  "qmk-toolbox"
  "qmk/qmk/qmk"
  "qsync-client"
  "raycast"
  "reaper"
  "ripgrep"
  "shellcheck"
  "softprops/tools/git-codeowners"
  "soundsource"
  "spotify"
  "starship"
  "tldr"
  "tmux"
  "tree"
  "vim"
  "wxmac"
  "yubikey-agent"
  "zsh"
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
)
brew install "${BREW_PACKAGES[@]}"
brew services start yubikey-agent
