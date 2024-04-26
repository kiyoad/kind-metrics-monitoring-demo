#!/bin/bash
set -euo pipefail
NAMESPACE=$(kubectl kustomize overlays | sed -ne "s/ *namespace: *\(.*\)/\1/p" | head -1)
echo USER: $(kubectl -n ${NAMESPACE} get secret grafana-demo -o jsonpath="{.data.admin-user}" | base64 -d)
echo PASS: $(kubectl -n ${NAMESPACE} get secret grafana-demo -o jsonpath="{.data.admin-password}" | base64 -d)

