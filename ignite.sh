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

CONFIG_DIRECTORY="${1:-/opt/t}"
CONFIG_GIT_REMOTE=git@github.com:TobiasBales/t.git

GROUP=$(id -gn)
UNAME=$(uname -s)

if ! [ -d "${CONFIG_DIRECTORY}" ]; then
  printTitle "${CONFIG_DIRECTORY} doesn't exist, creating"
  sudo mkdir -p "${CONFIG_DIRECTORY}"
  sudo chown -R "${USER}":"${GROUP}" "${CONFIG_DIRECTORY}"
  git clone "${CONFIG_GIT_REMOTE}" "${CONFIG_DIRECTORY}"
fi

if [ "${UNAME}" == "Darwin" ]; then
  if ! [ -f "/etc/sudoers.d/nix-darwin" ]; then
    printTitle "Making darwin-rebuild run without entering the password everytime, this requires root"
    sudo sh -c "echo \"${USER} ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild, /run/current-system/sw/bin/nix-env, /run/current-system/sw/bin/nix-build, /bin/launchctl, /run/current-system/sw/bin/ln, /nix/store/*/activate\" > /etc/sudoers.d/nix-darwin"
  fi
fi

if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if [[ "${UNAME}" == "Linux" && -n "$(command -v apt-get)" ]]; then
  if [[ -z "$(command -v sudo)" ]]; then
    apt-get update -y
    apt-get install -y sudo
  fi
  sudo apt-get update -y
  sudo apt-get install -y xz-utils
fi

set +u
if [[ "${GITHUB_ACTIONS}" == "true" && ! -d /etc/nix ]]; then
  sudo mkdir -p /etc/nix
  echo "build-users-group =" | sudo tee -a /etc/nix/nix.conf > /dev/null
  sudo chown -R "$(whoami)" /etc/nix
  sudo mkdir -p /nix
  sudo chown -R "$(whoami)" /nix
fi
set -u

if [ -z "$(command -v nix)" ]; then
  printTitle "Nix not found, installing"

  install_options=""
  if [ "${UNAME}" == "Darwin" ]; then
    install_options="--darwin-use-unencrypted-nix-store-volume"
  fi

  sh <(curl -L --silent https://nixos.org/nix/install) ${install_options}
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

export NIX_PATH=$HOME/.nix-defexpr/channels:${NIX_PATH}
export HOME_MANAGER_CONFIG="${CONFIG_DIRECTORY}/etc/nix/home.nix"

if [ -z "$(command -v home-manager)" ]; then
  printTitle "Home manager not found, installing"
  nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
  nix-channel --update

  nix-shell '<home-manager>' -A install
fi

export NIX_PATH=darwin-config="${CONFIG_DIRECTORY}/etc/nix/darwin.nix":${NIX_PATH}
export darwinConfig="${CONFIG_DIRECTORY}/etc/nix/nix-darwin.nix"

if [ "${UNAME}" == "Darwin" ] && [ -z "$(command -v darwin-rebuild)" ]; then
  echo "nix-darwin not found, installing"
  nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
  nix-channel --update
  nix-build '<darwin>' -A installer --out-link /tmp/nix-darwin && yes | /tmp/nix-darwin/bin/darwin-installer
fi

if [ ! -d /nix/var/nix/profiles/per-user/root/channels ]; then
  mkdir -p /nix/var/nix/profiles/per-user/root/channels
fi

nix-channel --update

printTitle "Switching to new generation"
if [ "${UNAME}" == "Darwin" ]; then
  darwin-rebuild switch
else
  home-manager switch
fi

