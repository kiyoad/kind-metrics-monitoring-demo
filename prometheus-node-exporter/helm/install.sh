#!/bin/bash
set -euxo pipefail
VERSION=$(../../kind/get-chart-ver.sh prometheus/node-exporter)
NAMESPACE=$(../../namespace/get.sh)
helm show values --version ${VERSION} --namespace ${NAMESPACE} prometheus-community/prometheus-node-exporter >values_${VERSION//./_}.yaml
helm template --version ${VERSION} --namespace ${NAMESPACE} demo prometheus-community/prometheus-node-exporter -f config.yaml | kubectl apply -f -
