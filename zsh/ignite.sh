#!/usr/bin/env bash

set -euo pipefail

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "Oh my zsh not found, installing"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -L "${HOME}/.zshrc" ]; then
  echo "zshrc not found, linking"
  rm -rf "${HOME}/.zshrc"
  ln -s "${CONFIG_DIRECTORY}/zsh/.zshrc" "${HOME}/.zshrc"
  set +u
  source "${HOME}/.zshrc"
  set -u
fi
