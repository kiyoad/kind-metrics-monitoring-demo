#!/bin/bash
set -euxo pipefail
kubectl apply --kustomize=overlays

