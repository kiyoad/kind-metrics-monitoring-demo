#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus -f prometheus-values.yaml | kubectl delete -f - || true
