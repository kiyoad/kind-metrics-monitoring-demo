#!/bin/bash
set -euxo pipefail
VERSION=$(../../kind/get-chart-ver.sh kube-state-metrics/kube-state-metrics)
NAMESPACE=$(../../namespace/get.sh)
helm show values --version ${VERSION} --namespace ${NAMESPACE} prometheus-community/kube-state-metrics >values_${VERSION//./_}.yaml
helm template --version ${VERSION} --namespace ${NAMESPACE} demo prometheus-community/kube-state-metrics -f config.yaml | kubectl apply -f -
