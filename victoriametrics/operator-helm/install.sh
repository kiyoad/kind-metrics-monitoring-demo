#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo vm/victoria-metrics-operator -f config.yaml | kubectl apply -f -
kubectl wait -A --for=condition=Ready pod --all
