#!/bin/bash
set -euxo pipefail
VERSION=$(../../kind/get-chart-ver.sh victoriametrics/operator)
NAMESPACE=$(../../namespace/get.sh)
helm show values --version ${VERSION} --namespace ${NAMESPACE} vm/victoria-metrics-operator >values_${VERSION//./_}.yaml
helm template --version ${VERSION} --namespace ${NAMESPACE} demo vm/victoria-metrics-operator -f config.yaml | kubectl apply -f -
kubectl wait -A --for=condition=Ready pod --all
