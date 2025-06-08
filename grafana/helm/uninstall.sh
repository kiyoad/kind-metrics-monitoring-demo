#!/bin/bash
set -euxo pipefail
helm template --version $(../../kind/get-chart-ver.sh grafana/grafana) --namespace $(../../namespace/get.sh) demo grafana/grafana -f config.yaml | kubectl delete -f - || true
