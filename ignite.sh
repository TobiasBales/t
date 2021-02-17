#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIRECTORY="${HOME}/projects/TobiasBales/t"
CONFIG_REMOTE=git@github.com:TobiasBales/t.git

set +u
SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -u

if [ "${SCRIPT_DIRECTORY}" != "${CONFIG_DIRECTORY}" ]; then
  echo "Running script not from config directory, cloning it"
  git clone "${CONFIG_REMOTE}" "${CONFIG_DIRECTORY}"
  exec "${CONFIG_DIRECTORY}/ignite.sh"
fi

./brew/ignite.sh
./starship/ignite.sh
./zsh/ignite.sh
./tmux/ignite.sh
./alacritty/ignite.sh
./asdf/ignite.sh
./vim/ignite.sh
./qmk/ignite.sh
./git/ignite.sh "${CONFIG_DIRECTORY}"
./scripts/ignite.sh
./macos/ignite.sh
