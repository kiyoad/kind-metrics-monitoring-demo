#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo prometheus-community/kube-state-metrics -f config.yaml | kubectl delete -f - || true

