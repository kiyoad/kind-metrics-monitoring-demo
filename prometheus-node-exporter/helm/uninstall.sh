#!/bin/bash
set -euxo pipefail
helm template --version $(../../kind/get-chart-ver.sh prometheus/node-exporter) --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-node-exporter -f config.yaml | kubectl delete -f - || true
