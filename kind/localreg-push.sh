#!/bin/bash
set -euo pipefail

FILE="images.lst"

while IFS= read -r LINE; do
  read LOCALTAG REMOTEIMG <<<"${LINE}"
  IFS='/' read REMOTEREG ORGANIZATION REPO <<<"${REMOTEIMG}"
  if [[ -z ${REPO} ]]; then
    IFS=':' read REPONAME REPOTAG <<<"${ORGANIZATION}"
    LOCALIMG=localhost:5001/${REPONAME}:${LOCALTAG}
  else
    IFS=':' read REPONAME REPOTAG <<<"${REPO}"
    LOCALIMG=localhost:5001/${ORGANIZATION}/${REPONAME}:${LOCALTAG}
  fi
  #echo LINE: ${LINE}
  #echo REMOTEREG: ${REMOTEREG}
  #echo ORGANIZATION: ${ORGANIZATION}
  #echo REPONAME: ${REPONAME}
  #echo REPOTAG: ${REPOTAG}
  docker tag ${REMOTEIMG} ${LOCALIMG}
  docker push ${LOCALIMG}
  docker image rm ${LOCALIMG}
done <"${FILE}"
