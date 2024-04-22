#!/bin/bash
set -euxo pipefail
kubectl apply -f base/release/crds
kubectl apply --kustomize=overlays
kubectl wait -A --for=condition=Ready pod --all

