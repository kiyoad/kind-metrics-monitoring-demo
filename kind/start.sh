#!/bin/bash
set -euxo pipefail
sed "s|%STORAGE_PATH%|$(pwd)|" cluster_tmpl.yaml | kind create cluster --config -
kubectl wait -A --for=condition=Ready pod --all
kubectl apply -f pv.yaml

