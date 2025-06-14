#!/bin/bash
set -euxo pipefail
cat ./prometheus-config-part.yaml ./serverFiles/$1.yaml >prometheus-config.yaml
helm template --version $(../../kind/get-chart-ver.sh prometheus/prometheus) --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus -f ./prometheus-config.yaml | kubectl delete -f - || true
rm -f ./prometheus-config.yaml
