#!/bin/bash
set -uo pipefail

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

    ./onepodpstatus.sh -n ${NAMESPACE} ${POD}
done
echo "]}"

