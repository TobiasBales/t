#!/usr/bin/env bash

set -euo pipefail

CONFIG_PATH=$(dirname "${0}")
LAST_RUN_FILE="${CONFIG_PATH}/.last_run_brew"
if ! [ -f "${LAST_RUN_FILE}" ]; then
  date +%s > "${LAST_RUN_FILE}" 
fi
LAST_RUN=$(cat "${LAST_RUN_FILE}")
NOW=$(date +%s)
TIME_SINCE_LAST_UPDATE="$((NOW-LAST_RUN))"
TIME_BETWEEN_UPDATES=$((60*60*24))
LAST_CHANGE=$(stat -f "%m" "${0}")

if [[ "${TIME_SINCE_LAST_UPDATE}" -le ${TIME_BETWEEN_UPDATES} ]] && [[ "${LAST_CHANGE}" -le ${LAST_RUN} ]]; then
  exit 0
fi
date +%s > "${LAST_RUN_FILE}"

if ! command -v brew &> /dev/null; then
  echo "Homebrew not found, installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating homebrew"
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew update
brew upgrade

echo "Installing homebrew packages"
BREW_PACKAGES=(
  "8bitdo-firmware-updater"
  "8bitdo-ultimate-software"
  "Arkweid/lefthook/lefthook"
  "anki"
  "audio-hijack"
  "autoconf"
  "awscli"
  "bat"
  "coreutils"
  "diff-so-fancy"
  "elgato-control-center"
  "elgato-stream-deck"
  "enpass"
  "exa"
  "farrago"
  "fd"
  "ffmpeg"
  "fission"
  "focusrite-control"
  "font-fira-code"
  "fzf"
  "gawk"
  "gh"
  "git"
  "git-interactive-rebase-tool"
  "git-trim"
  "gnu-sed"
  "gnuplot"
  "google-chrome"
  "gpg-suite"
  "grep"
  "guitar-pro"
  "homebrew/cask/docker"
  "httpie"
  "imagemagick"
  "intellij-idea"
  "istat-menus"
  "jetbrains-toolbox"
  "kitty"
  "loopback"
  "mediainfo"
  "neovim"
  "obs"
  "openemu"
  "openscad"
  "openssh"
  "overmind"
  "pinentry-mac"
  "plex"
  "prusaslicer"
  "pwgen"
  "qmk-toolbox"
  "qmk/qmk/qmk"
  "raycast"
  "reaper"
  "ripgrep"
  "shellcheck"
  "softprops/tools/git-codeowners"
  "soundsource"
  "spotify"
  "starship"
  "stow"
  "the-unarchiver"
  "tldr"
  "tmux"
  "tree"
  "up"
  "vim"
  "visual-studio-code"
  "wxmac"
  "zsh"
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
)
brew install "${BREW_PACKAGES[@]}"
