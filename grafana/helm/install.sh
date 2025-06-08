#!/bin/bash
set -euxo pipefail
helm show values --version $(../../kind/get-chart-ver.sh grafana/grafana) --namespace $(../../namespace/get.sh) grafana/grafana >values.yaml
helm template --version $(../../kind/get-chart-ver.sh grafana/grafana) --namespace $(../../namespace/get.sh) demo grafana/grafana -f config.yaml | kubectl apply -f -
