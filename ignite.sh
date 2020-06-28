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
UNAME=$(uname -s)

setup_catalina_root_mount() {
  path=$1
  name=$2
  echo $path | sudo tee -a /etc/synthetic.conf
  /System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -B
  echo "LABEL=$name /$path apfs rw" | sudo tee -a /etc/fstab
  sudo diskutil apfs addVolume disk1 APFSX $name -mountpoint /$path
  sudo diskutil enableOwnership /$path
  sudo chown -R $(whoami) /$path
  passphrase=$(ruby -rsecurerandom -e 'puts SecureRandom.hex(32)')
  uuid="$(diskutil info /nix | awk '$2 == "UUID:" { print $3 }')"
  echo $passphrase | sudo diskutil apfs enableFileVault /$path -user disk -stdinpassphrase
  security add-generic-password \
    -l "${name}" \
    -a "${uuid}" \
    -s "${uuid}" \
    -D "Encrypted Volume Password" \
    -w "${passphrase}" \
    -T "/System/Library/CoreServices/APFSUserAgent" \
    -T "/System/Library/CoreServices/CSUserAgent"
}

if ! [ -d "${CONFIG_DIRECTORY}" ]; then
  printTitle "${CONFIG_DIRECTORY} doesn't exist, creating"
  sudo mkdir "${CONFIG_DIRECTORY}"
  sudo chown -R "${USER}":"${GROUP}" "${CONFIG_DIRECTORY}"
  git clone "${CONFIG_GIT_REMOTE}" "${CONFIG_DIRECTORY}"
fi

if [ "${UNAME}" == "Darwin" ]; then
  if ! [ -f "/etc/sudoers.d/nix-darwin" ]; then
    printTitle "Making darwin-rebuild run without entering the password everytime, this requires root"
    sudo sh -c "echo \"${USER} ALL=(ALL:ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild, /run/current-system/sw/bin/nix-env, /run/current-system/sw/bin/nix-build, /bin/launchctl, /run/current-system/sw/bin/ln, /nix/store/*/activate\" > /etc/sudoers.d/nix-darwin"
  fi

  MACOS_VERSION=$(sw_vers -productVersion | grep -o "\d\d\.\d\d")
  if [ "${MACOS_VERSION}" != "10.14" ]; then
    echo "Assuming this is running on catalina, doing some prep work for nix"
    setup_catalina_root_mount t T
    setup_catalina_root_mount nix Nix
    setup_catalina_root_mount run Run
  fi

  if ! [ -L "/run" ]; then
    echo "Symlinking /run to /private/var/run, this requires root"
    sudo ln -s /private/var/run /run
  fi
fi

if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if [ -z "$(command -v nix)" ]; then
  printTitle "Nix not found, installing"
  curl -L https://nixos.org/nix/install | sh
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

if [ "$(git branch --show-current)" == "master" ]; then
  printTitle "Pulling latests changes"
  git -C "${CONFIG_DIRECTORY}" pull origin master
fi


printTitle "Switching to new generation"
if [ "${UNAME}" == "Darwin" ]; then
  darwin-rebuild switch
else
  home-manager switch
fi

