#!/bin/bash
set -euxo pipefail
helm template --version $(../../kind/get-chart-ver.sh kube-state-metrics/kube-state-metrics) --namespace $(../../namespace/get.sh) demo prometheus-community/kube-state-metrics -f config.yaml | kubectl delete -f - || true
