#!/usr/bin/env bash

set -euo pipefail

if [ ! -d "${HOME}/.asdf" ]; then
  echo "asdf not found, installing"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
fi

if [ ! -L "${HOME}/.asdfrc" ]; then
  echo "asdf config not found, linking"
  ln -s "${CONFIG_DIRECTORY}/asdf/.asdfrc" "${HOME}/.asdfrc"
fi

if ! asdf plugin list 2>&1 | grep -q "nodejs"; then
  echo "asdf nodejs plugin not found, installing it and latest nodejs"
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-previous-release-team-keyring'
  asdf install nodejs latest
  asdf global nodejs "$(asdf latest nodejs)"
fi

if ! asdf plugin list 2>&1 | grep -q "ruby"; then
  echo "asdf ruby plugin not found, installing it and latest ruby"
  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
  asdf install ruby latest
  asdf global ruby "$(asdf latest ruby)"
fi

if ! asdf plugin list 2>&1 | grep -q "golang"; then
  echo "asdf golang plugin not found, installing it and latest golang"
  asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
  asdf install golang latest
  asdf global golang "$(asdf latest golang)"
fi

if ! asdf plugin list 2>&1 | grep -q "java"; then
  echo "asdf java plugin not found, installing it and latest java"
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf install java openjdk-16
  asdf global java "$(asdf latest java)"
fi

if ! asdf plugin list 2>&1 | grep -q "gradle"; then
  echo "asdf gradle plugin not found, installing it and latest gradle"
  asdf plugin-add gradle https://github.com/rfrancis/asdf-gradle.git
  asdf install gradle latest
  asdf global gradle "$(asdf latest gradle)"
fi

if ! asdf plugin list 2>&1 | grep -q "python"; then
  echo "asdf python plugin not found, installing it and latest python"
  asdf plugin-add python https://github.com/danhper/asdf-python
  asdf install python latest
  asdf global python "$(asdf latest python)"
fi

if ! asdf plugin list 2>&1 | grep -q "erlang"; then
  echo "asdf erlang plugin not found, installing it and latest erlang"
  asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf install erlang latest
  asdf global erlang "$(asdf latest erlang)"
fi

if ! asdf plugin list 2>&1 | grep -q "haskell"; then
  echo "asdf haskell plugin not found, installing it and latest haskell"
  asdf plugin-add haskell https://github.com/vic/asdf-haskell.git
  asdf install haskell latest
  asdf global haskell "$(asdf latest haskell)"
fi

if ! asdf plugin list 2>&1 | grep -q "rust"; then
  echo "asdf rust plugin not found, installing it and latest rust"
  asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
  asdf install rust latest
  asdf global rust "$(asdf latest rust)"
fi

if ! asdf plugin list 2>&1 | grep -q "terraform"; then
  echo "asdf terraform plugin not found, installing it and latest terraform"
  asdf plugin-add terraform
  asdf install terraform latest
  asdf global terraform "$(asdf latest terraform)"
fi

echo "Updating asdf plugins"
asdf plugin update --all
