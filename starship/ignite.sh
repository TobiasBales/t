#!/usr/bin/env bash

set -euo pipefail

if [ ! -L "${HOME}/.config/starship.toml" ]; then
  echo "Starship config not found, linking"
  mkdir -p "${HOME}/.config"
  ln -s "${CONFIG_DIRECTORY}/starship/starship.config" "${HOME}/.config/starship.toml"
fi

