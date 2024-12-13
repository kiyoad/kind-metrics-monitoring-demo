#!/bin/bash
set -uo pipefail

usage() {
    echo "Usage: $0 [ -n namespace ] pod-name" >&2
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

PODNAME=""
NAMESPACE=default

while [ $# -gt 0 ]; do
    case "$1" in
        -n)
            shift
            if [ -z "$1" ]; then
                echo "Error: Option -n requires a namespace."
                usage
            fi
            NAMESPACE="$1"
            ;;
        *)
            if [ -z "$PODNAME" ]; then
                PODNAME="$1"
            else
                echo "Error: Unexpected argument $1."
                usage
            fi
            ;;
    esac
    shift
done

if [ -z "$PODNAME" ]; then
    echo "Error: pod-name is required."
    usage
fi



TMPFILE=$(mktemp)
function rm_tmpfile {
  [[ -f "$TMPFILE" ]] && rm -f "$TMPFILE"
}
trap rm_tmpfile EXIT
trap 'trap - EXIT; rm_tmpfile; exit -1' INT PIPE TERM



echo "{"
echo "\"Name\": \"${PODNAME}\","
echo "\"Container\": ["

CONTAINERS=$(kubectl get pod ${PODNAME} -n ${NAMESPACE} -o jsonpath='{range .spec.containers[*]}{.name}{" "}{end}')

cc2=0
for CONTAINER in ${CONTAINERS}; do
    if (( cc2 > 0 )); then
        echo ","
    fi
    (( cc2++ ))

    echo "{"
    echo "\"Name\": \"${CONTAINER}\","
    echo -n "\"Process\": ["

     
    if kubectl exec -n ${NAMESPACE} -c ${CONTAINER} ${PODNAME} -- /bin/ls -1 /proc > ${TMPFILE} 2> /dev/null; then
        PIDLIST=$(cat ${TMPFILE} | grep -E '^[0-9]+$' | sort -n | tr '\n' ' ')
        cc3=0
        for PID in ${PIDLIST}; do
            if kubectl exec -n ${NAMESPACE} -c ${CONTAINER} ${PODNAME} -- /bin/cat /proc/${PID}/status > ${TMPFILE} 2> /dev/null; then
                if (( cc3 > 0 )); then
                    echo ","
                fi
                (( cc3++ ))

                cat ${TMPFILE} | python3 ./proc1status2json.py
            fi
        done
    else
        echo -n "{}"
    fi 
    echo -n "]}"
done
echo -n "]}"

