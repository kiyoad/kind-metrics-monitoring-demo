#!/bin/bash
set -euxo pipefail
kubectl delete --kustomize=overlays

