#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./datasources-yaml-patcher.sh | kubectl delete -f - || /usr/bin/true
