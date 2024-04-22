#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./alertmanager-yaml-patcher.sh | kubectl apply -f -

