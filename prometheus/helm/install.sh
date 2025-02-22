#!/bin/bash
set -euxo pipefail
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
cat ./prometheus-config-part.yaml ./serverFiles/$1.yaml >prometheus-config.yaml
helm template --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus -f ./prometheus-config.yaml | kubectl apply -f -
rm -f ./prometheus-config.yaml
