#!/bin/bash
set -euxo pipefail
helm template --namespace monitoring demo prometheus-community/prometheus -f prometheus-values.yaml --version 23.1.0 | ./prometheus-tmpl-patcher.sh | kubectl delete -f -

