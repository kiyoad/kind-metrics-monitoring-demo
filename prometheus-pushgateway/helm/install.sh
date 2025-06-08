#!/bin/bash
set -euxo pipefail
helm show values --version $(../../kind/get-chart-ver.sh prometheus/pushgateway) --namespace $(../../namespace/get.sh) prometheus-community/prometheus-pushgateway >values.yaml
helm template --version $(../../kind/get-chart-ver.sh prometheus/pushgateway) --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-pushgateway -f config.yaml | kubectl apply -f -
