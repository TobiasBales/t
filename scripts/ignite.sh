#!/usr/bin/env bash

set -euo pipefail

if [ ! -L "/usr/local/bin/backup" ]; then
  echo "Backup script not found, linking"
  ln -s "${CONFIG_DIRECTORY}/scripts/backup" "/usr/local/bin/backup"
fi
