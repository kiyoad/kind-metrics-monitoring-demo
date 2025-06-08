#!/bin/bash
set -euxo pipefail
helm show values --version $(../../kind/get-chart-ver.sh prometheus/prometheus) --namespace $(../../namespace/get.sh) prometheus-community/prometheus >values.yaml
cat ./prometheus-config-part.yaml ./serverFiles/$1.yaml >prometheus-config.yaml
helm template --version $(../../kind/get-chart-ver.sh prometheus/prometheus) --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus -f ./prometheus-config.yaml | kubectl apply -f -
rm -f ./prometheus-config.yaml
