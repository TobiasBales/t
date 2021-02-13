#!/usr/bin/env bash

set -euo pipefail

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
