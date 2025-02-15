#!/bin/bash
set -euxo pipefail
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update
helm template --namespace $(../../namespace/get.sh) demo fluent/fluent-bit -f fluent-bit-values.yaml | ./fluent-bit-conf-patcher.sh | kubectl apply -f -
