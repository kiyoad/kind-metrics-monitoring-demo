#!/bin/bash
set -euxo pipefail
helm template --version $(../../kind/get-chart-ver.sh prometheus/pushgateway) --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-pushgateway -f config.yaml | kubectl delete -f - || true
kubectl patch pv worker-pv35 -p '{"spec":{"claimRef": null}}'
