#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | kubectl delete -f - || true
