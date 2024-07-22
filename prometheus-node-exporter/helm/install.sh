#!/bin/bash
set -euxo pipefail
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm template --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-node-exporter -f config.yaml | kubectl apply -f -

