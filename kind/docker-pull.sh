#!/bin/bash
set -euo pipefail

FILE="images.lst"

while IFS= read -r LINE; do
  read LOCALTAG REMOTEREPO <<<"${LINE}"
  docker pull ${REMOTEREPO}
done <"${FILE}"
