#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./vmalert-vmalertmanager-patcher.sh | kubectl apply -f -

