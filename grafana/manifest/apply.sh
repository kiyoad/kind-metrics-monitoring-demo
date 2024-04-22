#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./datasources-yaml-patcher.sh | kubectl apply -f -

