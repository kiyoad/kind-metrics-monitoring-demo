#!/bin/bash
set -euo pipefail

FILE="images.lst"

while IFS= read -r MIXLINE; do
  LINE="${MIXLINE%%#*}"
  if [[ -z ${LINE} ]]; then
    continue
  fi
  #echo LINE: ${LINE}
  read LOCALTAG REMOTENAMETAG CHARTVERSION <<<"${LINE}"
  #echo LOCALTAG: ${LOCALTAG} REMOTENAMETAG: ${REMOTENAMETAG} CHARTVERSION: ${CHARTVERSION}
  docker pull ${REMOTENAMETAG}
done <"${FILE}"
