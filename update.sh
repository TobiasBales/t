#!/usr/bin/env bash

set -euo pipefail

LAST_RUN_FILE=".last_run"

if ! [ -f "${LAST_RUN_FILE}" ]; then
  date +%s > "${LAST_RUN_FILE}" 
fi

LAST_RUN=$(cat "${LAST_RUN_FILE}")
NOW=$(date +%s)
TIME_SINCE_LAST_UPDATE="$(($NOW-$LAST_RUN))"
TIME_BETWEEN_UPDATES=$((60*24))

if [ "${TIME_SINCE_LAST_UPDATE}" -gt ${TIME_BETWEEN_UPDATES} ]; then
  date +%s > "${LAST_RUN_FILE}" 
  exec ./ignite.sh
fi
