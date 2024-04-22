#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./prometheus-yml-patcher.sh | kubectl apply -f -

