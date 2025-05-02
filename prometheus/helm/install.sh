#!/bin/bash
set -euxo pipefail
cat ./prometheus-config-part.yaml ./serverFiles/$1.yaml >prometheus-config.yaml
helm template --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus -f ./prometheus-config.yaml | kubectl apply -f -
rm -f ./prometheus-config.yaml
