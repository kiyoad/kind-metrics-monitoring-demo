#!/bin/bash
set -euxo pipefail

cat << EOF > overlays/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../base
namespace: $(../../namespace/get.sh)
EOF

kubectl kustomize overlays | kubectl apply -f -

