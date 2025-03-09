#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./nginx-conf-patcher.sh | kubectl delete -f - || true
