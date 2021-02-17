#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIRECTORY="${1}"

if [ ! -L "${HOME}/.gitconfig" ]; then
  echo "git config not found, linking"
  ln -s "${CONFIG_DIRECTORY}/git/.gitconfig" "${HOME}/.gitconfig"
fi

if [ ! -L "${HOME}/.gitignore" ]; then
  echo "git ignore not found, linking"
  ln -s "${CONFIG_DIRECTORY}/git/.gitignore" "${HOME}/.gitignore"
fi
