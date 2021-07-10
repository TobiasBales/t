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
"${CONFIG_DIRECTORY}/starship/ignite.sh" "${CONFIG_DIRECTORY}"
"${CONFIG_DIRECTORY}/zsh/ignite.sh" "${CONFIG_DIRECTORY}"
"${CONFIG_DIRECTORY}/tmux/ignite.sh" "${CONFIG_DIRECTORY}"
"${CONFIG_DIRECTORY}/kitty/ignite.sh" "${CONFIG_DIRECTORY}"
"${CONFIG_DIRECTORY}/asdf/ignite.sh" "${CONFIG_DIRECTORY}"
stow nvim
"${CONFIG_DIRECTORY}/qmk/ignite.sh" "${CONFIG_DIRECTORY}"
"${CONFIG_DIRECTORY}/git/ignite.sh" "${CONFIG_DIRECTORY}"
"${CONFIG_DIRECTORY}/scripts/ignite.sh" "${CONFIG_DIRECTORY}"
"${CONFIG_DIRECTORY}/macos/ignite.sh" "${CONFIG_DIRECTORY}"
