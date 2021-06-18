#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIRECTORY="${1}"

if [ ! -L "${HOME}/.config/kitty/kitty.conf" ]; then
  echo "Kitty config not found, linking"
  mkdir -p "${HOME}/.config/kitty"
  rm -rf "${HOME}/.config/kitty/kitty.conf"
  ln -s "${CONFIG_DIRECTORY}/kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
fi
