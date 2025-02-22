#!/bin/bash
set -euxo pipefail
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm template --namespace $(../../namespace/get.sh) demo grafana/grafana -f grafana-values.yaml | kubectl apply -f -
