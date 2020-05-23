#!/usr/bin/env bash

set -euo pipefail

printTitle() {
  SEPARATOR="                                       ="
  echo ""
  echo ""
  echo ""
  echo "==========================================="
  printf "= %s %s\n" "${1}" "${SEPARATOR:${#1}}"
  echo "==========================================="
  echo ""
}

CONFIG_DIRECTORY="${1:-/t}"
CONFIG_GIT_REMOTE=git@github.com:TobiasBales/t.git

GROUP=$(id -gn)

if ! [ -d "${CONFIG_DIRECTORY}" ]; then
  printTitle "${CONFIG_DIRECTORY} doesn't exist, creating"
  sudo mkdir "${CONFIG_DIRECTORY}"
  sudo chown -R "${USER}":"${GROUP}" "${CONFIG_DIRECTORY}"
  git clone "${CONFIG_GIT_REMOTE}" "${CONFIG_DIRECTORY}"
fi

if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if [ -z "$(command -v nix)" ]; then
  printTitle "Nix not found, installing"
  curl -L https://nixos.org/nix/install | sh
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  # source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# fi

export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
export HOME_MANAGER_CONFIG="${CONFIG_DIRECTORY}/etc/nix/home.nix"

if [ -z "$(command -v home-manager)" ]; then
  printTitle "Home manager not found, installing"
  nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
  nix-channel --update

  nix-shell '<home-manager>' -A install
fi

# printTitle "Pulling latests changes"
# git -C "${CONFIG_DIRECTORY} pull origin master

printTitle "Switching to new generation"
home-manager switch

