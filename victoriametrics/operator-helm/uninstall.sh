#!/bin/bash
set -euxo pipefail
helm template --namespace monitoring demo vm/victoria-metrics-operator -f config.yaml | kubectl delete -f - || /usr/bin/true

