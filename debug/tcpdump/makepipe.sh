#!/bin/bash
set -euo pipefail
NAMESPACE=monitoring
MANIFESTSDIR=./manifests
TOOLNAME=httpdump
TMPLMANIFEST=./${TOOLNAME}/${TOOLNAME}.yaml
TMPLMAKEFILE=./${TOOLNAME}/Makefile.tmpl

if [[ -x /opt/homebrew/bin/gsed ]]; then
    SED=/opt/homebrew/bin/gsed
else
    SED=sed
fi

usage() {
    echo "Usage: makepipe.sh http-host:port [directory]"
    exit 1
}

if [[ $# -ne 1 && $# -ne 2 ]]; then
    usage
fi

IFS=':' read -r HOST PORTDIR <<< "$1"
if [[ $# -eq 2 ]]; then
    PORT=${PORTDIR}
    DIR="$2"
else
    PORT="${PORTDIR%%[!0-9]*}"
    DIR="${PORTDIR#"$PORT"}"
fi

if [[ -z "${PORT}" ]]; then
    usage
fi

if [[ ! "${PORT}" =~ ^[0-9]{4,5}$ ]]; then
    usage
fi

#echo ${HOST}
#echo ${PORT}
#echo ${DIR}

S='pipe-8888-'${HOST}'-'${PORT}${DIR%%/}
PODNAME=${S//\//-}
#echo ${PODNAME}
OUTDIR=${MANIFESTSDIR}/${PODNAME}
OUTMANIFEST=${OUTDIR}/manifest.yaml
OUTMAKEFILE=${OUTDIR}/Makefile
mkdir -p ${OUTDIR}

#touch ${OUTMANIFEST}
#touch ${OUTMAKEFILE}

${SED} -e "s| httpdump| ${PODNAME}|" ${TMPLMANIFEST} > ${OUTMANIFEST}
${SED} -i -e "s|httpbin\\.org:80|${HOST}:${PORT}|" ${OUTMANIFEST}
if [[ -n "${DIR}" ]]; then
    ${SED} -i -e "/${HOST}:${PORT}/a\\
      - \"${DIR}\"" ${OUTMANIFEST}
fi

${SED} -e "s|default|${NAMESPACE}|" -e "s|httpdump|${PODNAME}|" ${TMPLMAKEFILE} > ${OUTMAKEFILE}

