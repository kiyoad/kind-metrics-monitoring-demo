#!/bin/bash
set -euxo pipefail
VERSION=$(../../kind/get-chart-ver.sh prometheus/pushgateway)
NAMESPACE=$(../../namespace/get.sh)
helm show values --version ${VERSION} --namespace ${NAMESPACE} prometheus-community/prometheus-pushgateway >values_${VERSION//./_}.yaml
helm template --version ${VERSION} --namespace ${NAMESPACE} demo prometheus-community/prometheus-pushgateway -f config.yaml | kubectl apply -f -
