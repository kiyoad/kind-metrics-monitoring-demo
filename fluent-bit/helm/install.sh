#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo fluent/fluent-bit -f fluent-bit-values.yaml | ./fluent-bit-conf-patcher.sh | kubectl apply -f -
