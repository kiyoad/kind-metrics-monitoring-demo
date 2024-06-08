#!/bin/bash
set -euxo pipefail
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm template --namespace monitoring demo grafana/grafana -f grafana-values.yaml | ./grafana-tmpl-patcher.sh | kubectl apply -f -
sleep 5
kubectl delete pod -n monitoring demo-grafana-test || /usr/bin/true

