#!/bin/bash
set -euxo pipefail
helm template --version $(../../kind/get-chart-ver.sh fluent/fluent-bit) --namespace $(../../namespace/get.sh) demo fluent/fluent-bit -f config.yaml | ./fluent-bit-conf-patcher.sh | kubectl delete -f - || true
