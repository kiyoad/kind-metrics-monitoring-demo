#!/bin/bash
set -euxo pipefail
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm template --namespace monitoring demo grafana/grafana -f grafana-values.yaml | ./grafana-tmpl-patcher.sh | kubectl apply -f -
