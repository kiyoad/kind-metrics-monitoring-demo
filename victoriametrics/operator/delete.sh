#!/bin/bash
set -euxo pipefail
kubectl delete --kustomize=overlays || /usr/bin/true
kubectl delete -f base/release/crds || /usr/bin/true
