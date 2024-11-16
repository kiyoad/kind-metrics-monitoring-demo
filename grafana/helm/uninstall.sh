#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo grafana/grafana -f grafana-values.yaml | kubectl delete -f - || true
