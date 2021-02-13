#!/usr/bin/env bash

set -euo pipefail

if [ ! -L "${HOME}/.alacritty.yml" ]; then
  echo "Alacritty config not found, linking"
  rm -rf "${HOME}/.alacritty.yml"
  ln -s "${CONFIG_DIRECTORY}/alacritty/.alacritty.yml" "${HOME}/.alacritty.yml"
fi
