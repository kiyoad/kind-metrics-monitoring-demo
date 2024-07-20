#!/bin/bash
set -euxo pipefail
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm template --namespace monitoring demo prometheus-community/prometheus-blackbox-exporter -f config.yaml | kubectl apply -f -

