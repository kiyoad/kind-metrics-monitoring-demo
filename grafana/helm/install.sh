#!/bin/bash
set -euxo pipefail
VERSION=$(../../kind/get-chart-ver.sh grafana/grafana)
NAMESPACE=$(../../namespace/get.sh)
helm show values --version ${VERSION} --namespace ${NAMESPACE} grafana/grafana >values_${VERSION//./_}.yaml
helm template --version ${VERSION} --namespace ${NAMESPACE} demo grafana/grafana -f config.yaml | kubectl apply -f -
