#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo vm/victoria-metrics-operator -f config.yaml | kubectl delete -f - || true

