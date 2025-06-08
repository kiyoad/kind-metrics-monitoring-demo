#!/bin/bash
set -euxo pipefail
helm show values --version $(../../kind/get-chart-ver.sh prometheus/node-exporter) --namespace $(../../namespace/get.sh) prometheus-community/prometheus-node-exporter >values.yaml
helm template --version $(../../kind/get-chart-ver.sh prometheus/node-exporter) --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-node-exporter -f config.yaml | kubectl apply -f -
