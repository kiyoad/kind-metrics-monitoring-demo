#!/bin/bash
set -euxo pipefail
VERSION=$(../../kind/get-chart-ver.sh prometheus/prometheus)
NAMESPACE=$(../../namespace/get.sh)
helm show values --version ${VERSION} --namespace ${NAMESPACE} prometheus-community/prometheus >values_${VERSION//./_}.yaml
cat ./prometheus-config-part.yaml ./serverFiles/$1.yaml >prometheus-config.yaml
helm template --version ${VERSION} --namespace ${NAMESPACE} demo prometheus-community/prometheus -f ./prometheus-config.yaml | kubectl apply -f -
rm -f ./prometheus-config.yaml
