#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./fluent-bit-conf-patcher.sh | kubectl delete -f - || true
