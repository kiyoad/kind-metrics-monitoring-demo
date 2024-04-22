#!/bin/bash
set -euxo pipefail
kubectl delete --kustomize=overlays
kubectl delete -f base/release/crds

