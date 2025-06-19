#!/bin/bash
set -euxo pipefail
VERSION=$(../../kind/get-chart-ver.sh fluent/fluent-bit)
NAMESPACE=$(../../namespace/get.sh)
helm show values --version ${VERSION} --namespace ${NAMESPACE} fluent/fluent-bit >values_${VERSION//./_}.yaml
helm template --version ${VERSION} --namespace ${NAMESPACE} demo fluent/fluent-bit -f config.yaml | ./fluent-bit-conf-patcher.sh | kubectl apply -f -
