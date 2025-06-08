#!/bin/bash
set -euxo pipefail
helm show values --version $(../../kind/get-chart-ver.sh fluent/fluent-bit) --namespace $(../../namespace/get.sh) fluent/fluent-bit >values.yaml
helm template --version $(../../kind/get-chart-ver.sh fluent/fluent-bit) --namespace $(../../namespace/get.sh) demo fluent/fluent-bit -f config.yaml | ./fluent-bit-conf-patcher.sh | kubectl apply -f -
