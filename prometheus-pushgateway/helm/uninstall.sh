#!/bin/bash
set -euxo pipefail
helm template --namespace monitoring demo prometheus-community/prometheus-pushgateway -f config.yaml | kubectl delete -f - || /usr/bin/true

