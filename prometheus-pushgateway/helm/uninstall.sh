#!/bin/bash
set -euxo pipefail
helm template --namespace $(../../namespace/get.sh) demo prometheus-community/prometheus-pushgateway -f config.yaml | kubectl delete -f - || true
kubectl patch pv worker-pv35 -p '{"spec":{"claimRef": null}}'
