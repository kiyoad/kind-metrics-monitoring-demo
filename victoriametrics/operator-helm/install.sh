#!/bin/bash
set -euxo pipefail
helm show values --version $(../../kind/get-chart-ver.sh victoriametrics/operator) --namespace $(../../namespace/get.sh) vm/victoria-metrics-operator >values.yaml
helm template --version $(../../kind/get-chart-ver.sh victoriametrics/operator) --namespace $(../../namespace/get.sh) demo vm/victoria-metrics-operator -f config.yaml | kubectl apply -f -
kubectl wait -A --for=condition=Ready pod --all
