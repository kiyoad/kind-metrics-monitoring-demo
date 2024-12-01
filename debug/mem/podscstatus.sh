#!/bin/bash
set -uo pipefail

TMPFILE=$(mktemp)
function rm_tmpfile {
  [[ -f "$TMPFILE" ]] && rm -f "$TMPFILE"
}
trap rm_tmpfile EXIT
trap 'trap - EXIT; rm_tmpfile; exit -1' INT PIPE TERM

NAMESPACE=monitoring
PODS=$(kubectl get pods -n ${NAMESPACE} -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}')

echo "{"
echo "\"Pod\": ["

cc1=0
for POD in ${PODS}; do
    if (( cc1 > 0 )); then
        echo ","
    fi
    (( cc1++ ))

    echo "{"
    echo "\"Name\": \"${POD}\","
    echo "\"Container\": ["

    CONTAINERS=$(kubectl get pod ${POD} -n ${NAMESPACE} -o jsonpath='{range .spec.containers[*]}{.name}{" "}{end}')

    cc2=0
    for CONTAINER in ${CONTAINERS}; do
        if (( cc2 > 0 )); then
            echo ","
        fi
        (( cc2++ ))

        echo "{"
        echo "\"Name\": \"${CONTAINER}\","
        echo -n "\"Status\": "

        if kubectl exec -n ${NAMESPACE} -it -c ${CONTAINER} ${POD} -- /bin/cat /proc/1/status > ${TMPFILE} 2> /dev/null; then
#            NAME=$( grep "^Name:"  ${TMPFILE} | awk '{gsub(/\r/, ""); print $2}')
#            VMRSS=$(grep "^VmRSS:" ${TMPFILE} | awk '{gsub(/\r/, ""); print $2}')
#            echo "${POD} ${NAME} ${VMRSS} kB(VmRSS)"
            cat ${TMPFILE} | python3 ./proc1status2json.py
        else
#            echo "${POD} UNKNOWN 0 kB(VmRSS)"
            echo -n "{}"
        fi
        echo -n "}"
    done
    echo -n "]}"
done
echo "]}"

