#!/bin/bash
set -euxo pipefail
helm show values --version $(../../kind/get-chart-ver.sh kube-state-metrics/kube-state-metrics) --namespace $(../../namespace/get.sh) prometheus-community/kube-state-metrics >values.yaml
helm template --version $(../../kind/get-chart-ver.sh kube-state-metrics/kube-state-metrics) --namespace $(../../namespace/get.sh) demo prometheus-community/kube-state-metrics -f config.yaml | kubectl apply -f -
