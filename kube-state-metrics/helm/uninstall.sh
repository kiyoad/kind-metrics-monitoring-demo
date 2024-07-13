#!/bin/bash
set -euxo pipefail
helm template --namespace monitoring demo prometheus-community/kube-state-metrics -f config.yaml | kubectl delete -f - || /usr/bin/true

