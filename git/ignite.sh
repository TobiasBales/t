#!/usr/bin/env bash

set -euo pipefail

if [ ! -L "${HOME}/.gitconfig" ]; then
  echo "git config not found, linking"
  ln -s "${CONFIG_DIRECTORY}/git/.gitconfig" "${HOME}/.gitconfig"
fi
