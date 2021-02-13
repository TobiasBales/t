#!/usr/bin/env bash

set -euo pipefail

if [ ! -d "${HOME}/projects/TobiasBales/qmk_firmware" ]; then
  echo "Qmk not configured, installing"
  yes | qmk setup TobiasBales/qmk_firmware -H "${HOME}/projects/TobiasBales/qmk_firmware"
  qmk config user.keyboard=kyria
  qmk config user.keymap=TobiasBales
fi

