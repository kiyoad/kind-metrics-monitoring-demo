#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | kubectl delete -f - || true
kubectl patch pv worker-pv44 -p '{"spec":{"claimRef": null}}'
