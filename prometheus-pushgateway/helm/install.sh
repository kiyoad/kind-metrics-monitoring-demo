#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-pushgateway -f config.yaml | kubectl apply -f -
