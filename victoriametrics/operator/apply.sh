#!/bin/bash
set -euxo pipefail
if ! [[ -d base/release ]]; then
    (cd base && bash -c ./get_operator.sh)
fi
kubectl apply -f base/release/crds
kubectl apply --kustomize=overlays
kubectl wait -A --for=condition=Ready pod --all

