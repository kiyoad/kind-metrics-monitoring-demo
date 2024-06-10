#!/bin/bash
set -euxo pipefail
helm template --namespace monitoring demo prometheus-community/prometheus -f prometheus-values.yaml | ./prometheus-tmpl-patcher.sh | kubectl delete -f - || /usr/bin/true
