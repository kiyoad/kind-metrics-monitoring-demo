#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./vmalert-vmalertmanager-patcher.sh | kubectl delete -f - || true
