#!/bin/bash
set -uo pipefail
MIXLINE=$(grep $1 $(dirname $0)/images.lst)
if [[ -z ${MIXLINE} ]]; then
  echo "ERROR: Undefined chart version." >&2
  exit 1
fi
LINE="${MIXLINE%%#*}"
read LOCALTAG REMOTENAMETAG CHARTVERSION <<<${LINE}
if [[ ! "$CHARTVERSION" =~ ^[0-9]+(\.[0-9]+)*$ ]]; then
  echo "ERROR: Invalid chart version." >&2
  exit 1
fi
echo ${CHARTVERSION}
