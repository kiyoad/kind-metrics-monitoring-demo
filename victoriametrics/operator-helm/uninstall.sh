#!/bin/bash
set -euxo pipefail
helm template --version $(../../kind/get-chart-ver.sh victoriametrics/operator) --namespace $(../../namespace/get.sh) demo vm/victoria-metrics-operator -f config.yaml | kubectl delete -f - || true
