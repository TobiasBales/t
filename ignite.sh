#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIRECTORY="${HOME}/projects/TobiasBales/t"
CONFIG_REMOTE=git@github.com:TobiasBales/t.git

SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "${SCRIPT_DIRECTORY}" != "${CONFIG_DIRECTORY}" ]; then
  echo "Running script not from config directory, cloning it"
  git clone "${CONFIG_REMOTE}" "${CONFIG_DIRECTORY}"
  exec "${CONFIG_DIRECTORY}/ignite.sh"
fi

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
  "alacritty"
  "audio-hijack"
  "autoconf"
  "awscli"
  "bat"
  "coreutils"
  "diff-so-fancy"
  "enpass"
  "exa"
  "farrago"
  "fission"
  "font-jetbrains-mono-nerd-font"
  "fzf"
  "gawk"
  "gh"
  "git"
  "git-interactive-rebase-tool"
  "git-trim"
  "google-chrome"
  "gpg"
  "httpie"
  "intellij-idea"
  "loopback"
  "neovim"
  "obs"
  "qmk-toolbox"
  "qmk/qmk/qmk"
  "raycast"
  "ripgrep"
  "shellcheck"
  "softprops/tools/git-codeowners"
  "tldr"
  "tmux"
  "vim"
  "wxmac"
  "yubikey-agent"
  "zsh"
)
brew install "${BREW_PACKAGES[@]}"
brew services start yubikey-agent

if [ ! -d "${HOME}/.asdf" ]; then
  echo "asdf not found, installing"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
fi

if [ ! -L "${HOME}/.asdfrc" ]; then
  echo "asdf config not found, linking"
  ln -s "${CONFIG_DIRECTORY}/asdf/.asdfrc" "${HOME}/.asdfrc"
fi

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "Oh my zsh not found, installing"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -L "${HOME}/.alacritty.yml" ]; then
  echo "Alacritty config not found, linking"
  rm -rf "${HOME}/.alacritty.yml"
  ln -s "${CONFIG_DIRECTORY}/alacritty/.alacritty.yml" "${HOME}/.alacritty.yml"
fi

if [ ! -L "${HOME}/.zshrc" ]; then
  echo "zshrc not found, linking"
  rm -rf "${HOME}/.zshrc"
  ln -s "${CONFIG_DIRECTORY}/zsh/.zshrc" "${HOME}/.zshrc"
  set +u
  source "${HOME}/.zshrc"
  set -u
fi

if [ ! -L "${HOME}/.tmux.conf" ]; then
  echo "tmux config not found, linking"
  rm -rf "${HOME}/.tmux.conf"
  ln -s "${CONFIG_DIRECTORY}/tmux/.tmux.conf" "${HOME}/.tmux.conf"
fi

if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
  echo "tpm not found, installing"
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -f "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
  echo "Plug.vim not found, installing"
  sh -c "curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

if [ ! -L "${HOME}/.config/nvim/init.vim" ]; then
  echo "Neovim config not found, linking"
  ln -s "${CONFIG_DIRECTORY}/vim/init.vim" "${HOME}/.config/nvim/init.vim"
fi

if [ ! -L "${HOME}/.config/nvim/coc-settings.json" ]; then
  echo "coc config not found, linking"
  mkdir -p "${HOME}/.config/nvim"
  ln -s "${CONFIG_DIRECTORY}/vim/coc-settings.json" "${HOME}/.config/nvim/coc-settings.json"
fi

if [ ! -L "${HOME}/.gitconfig" ]; then
  echo "git config not found, linking"
  ln -s "${CONFIG_DIRECTORY}/git/.gitconfig" "${HOME}/.gitconfig"
fi

if [ ! -d "${HOME}/projects/TobiasBales/qmk_firmware" ]; then
  echo "Qmk not configured, installing"
  yes | qmk setup TobiasBales/qmk_firmware -H "${HOME}/projects/TobiasBales/qmk_firmware"
  qmk config user.keyboard=kyria
  qmk config user.keymap=TobiasBales
fi

if ! asdf plugin list 2>&1 | grep -q "nodejs"; then
  echo "asdf nodejs plugin not found, installing it and latest nodejs"
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-previous-release-team-keyring'
  asdf install nodejs latest
  asdf global nodejs "$(asdf latest nodejs)"
fi

if ! asdf plugin list 2>&1 | grep -q "ruby"; then
  echo "asdf ruby plugin not found, installing it and latest ruby"
  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
  asdf install ruby latest
  asdf global ruby "$(asdf latest ruby)"
fi

if ! asdf plugin list 2>&1 | grep -q "golang"; then
  echo "asdf golang plugin not found, installing it and latest golang"
  asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
  asdf install golang latest
  asdf global golang "$(asdf latest golang)"
fi

if ! asdf plugin list 2>&1 | grep -q "java"; then
  echo "asdf java plugin not found, installing it and latest java"
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf install java openjdk-16
  asdf global java "$(asdf latest java)"
fi

if ! asdf plugin list 2>&1 | grep -q "gradle"; then
  echo "asdf gradle plugin not found, installing it and latest gradle"
  asdf plugin-add gradle https://github.com/rfrancis/asdf-gradle.git
  asdf install gradle latest
  asdf global gradle "$(asdf latest gradle)"
fi

if ! asdf plugin list 2>&1 | grep -q "python"; then
  echo "asdf python plugin not found, installing it and latest python"
  asdf plugin-add python https://github.com/danhper/asdf-python
  asdf install python latest
  asdf global python "$(asdf latest python)"
fi

if ! asdf plugin list 2>&1 | grep -q "erlang"; then
  echo "asdf erlang plugin not found, installing it and latest erlang"
  asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf install erlang latest
  asdf global erlang "$(asdf latest erlang)"
fi

if ! asdf plugin list 2>&1 | grep -q "haskell"; then
  echo "asdf haskell plugin not found, installing it and latest haskell"
  asdf plugin-add haskell https://github.com/vic/asdf-haskell.git
  asdf install haskell latest
  asdf global haskell "$(asdf latest haskell)"
fi

if ! asdf plugin list 2>&1 | grep -q "rust"; then
  echo "asdf rust plugin not found, installing it and latest rust"
  asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
  asdf install rust latest
  asdf global rust "$(asdf latest rust)"
fi

echo "Updating asdf plugins"
asdf plugin update --all

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

