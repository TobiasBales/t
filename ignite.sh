#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIRECTORY="${HOME}/.dotfiles"
CONFIG_REMOTE=git@github.com:TobiasBales/t.git

set +u
SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -u

if [ "${SCRIPT_DIRECTORY}" != "${CONFIG_DIRECTORY}" ]; then
  echo "Running script not from config directory, cloning it"
  git clone "${CONFIG_REMOTE}" "${CONFIG_DIRECTORY}"
  exec "${CONFIG_DIRECTORY}/ignite.sh"
fi

"${CONFIG_DIRECTORY}/brew/ignite.sh" "${CONFIG_DIRECTORY}"
stow starship
stow kitty

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "Oh my zsh not found, installing"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
stow zsh
"${CONFIG_DIRECTORY}/tmux/ignite.sh" "${CONFIG_DIRECTORY}"
stow tmux
stow nvim
stow git
if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
  echo "tpm not found, installing"
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
"${CONFIG_DIRECTORY}/asdf/ignite.sh" "${CONFIG_DIRECTORY}"
stow nvim
"${CONFIG_DIRECTORY}/qmk/ignite.sh" "${CONFIG_DIRECTORY}"
stow git
"${CONFIG_DIRECTORY}/scripts/ignite.sh" "${CONFIG_DIRECTORY}"
"${CONFIG_DIRECTORY}/macos/ignite.sh" "${CONFIG_DIRECTORY}"
