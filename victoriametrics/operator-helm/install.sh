#!/bin/bash
set -euxo pipefail
helm repo add vm https://victoriametrics.github.io/helm-charts
helm repo update
helm template --namespace monitoring demo vm/victoria-metrics-operator -f config.yaml | kubectl apply -f -
kubectl wait -A --for=condition=Ready pod --all

