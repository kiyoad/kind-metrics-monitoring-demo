#!/bin/bash
set -euxo pipefail
helm show values --version $(../../kind/get-chart-ver.sh prometheus/blackbox-exporter) --namespace $(../../namespace/get.sh) prometheus-community/prometheus-blackbox-exporter >values.yaml
helm template --version $(../../kind/get-chart-ver.sh prometheus/blackbox-exporter) --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-blackbox-exporter -f config.yaml | kubectl apply -f -
