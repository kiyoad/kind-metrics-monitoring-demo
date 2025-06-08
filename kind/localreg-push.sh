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
  IFS='/' read REMOTEREG ORGANIZATION REPO <<<"${REMOTENAMETAG}"
  if [[ -z ${REPO} ]]; then
    IFS=':' read REPONAME REPOTAG <<<"${ORGANIZATION}"
    LOCALIMG=localhost:5001/${REPONAME}:${LOCALTAG}
  else
    IFS=':' read REPONAME REPOTAG <<<"${REPO}"
    LOCALIMG=localhost:5001/${ORGANIZATION}/${REPONAME}:${LOCALTAG}
  fi
  #echo LOCALIMG: ${LOCALIMG}
  docker tag ${REMOTENAMETAG} ${LOCALIMG}
  docker push ${LOCALIMG}
  docker image rm ${LOCALIMG}
done <"${FILE}"
