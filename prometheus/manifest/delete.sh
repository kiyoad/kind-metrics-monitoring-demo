#!/bin/bash
set -euxo pipefail
kubectl kustomize overlays | ./prometheus-yml-patcher.sh | kubectl delete -f - || /usr/bin/true

