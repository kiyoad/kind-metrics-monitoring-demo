#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-node-exporter -f config.yaml | kubectl delete -f - || true

