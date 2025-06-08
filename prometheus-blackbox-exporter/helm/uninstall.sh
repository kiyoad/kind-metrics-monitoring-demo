#!/bin/bash
set -euxo pipefail
helm template --version $(../../kind/get-chart-ver.sh prometheus/blackbox-exporter) --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-blackbox-exporter -f config.yaml | kubectl delete -f - || true
