#!/usr/bin/env bash

CONFIG_PATH=$(dirname "${0}")

set -euo pipefail

LAST_RUN_FILE="${CONFIG_PATH}/.last_run"

if ! [ -f "${LAST_RUN_FILE}" ]; then
  date +%s > "${LAST_RUN_FILE}" 
fi

LAST_RUN=$(cat "${LAST_RUN_FILE}")
NOW=$(date +%s)
TIME_SINCE_LAST_UPDATE="$((NOW-LAST_RUN))"
TIME_BETWEEN_UPDATES=$((60*60*1))

if [ "${TIME_SINCE_LAST_UPDATE}" -gt ${TIME_BETWEEN_UPDATES} ]; then
  date +%s > "${LAST_RUN_FILE}" 
  exec "${CONFIG_PATH}/ignite.sh"
fi
