#!/usr/bin/env bash

set -euo pipefail

if [ ! -f "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then
  echo "Plug.vim not found, installing"
  sh -c "curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

if [ ! -L "${HOME}/.config/nvim/init.vim" ]; then
  echo "Neovim config not found, linking"
  ln -s "${CONFIG_DIRECTORY}/vim/init.vim" "${HOME}/.config/nvim/init.vim"
fi

