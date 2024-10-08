#!/bin/bash
set -euxo pipefail
sed "s|%STORAGE_PATH%|$(pwd)|" cluster_tmpl.yaml | kind create cluster --config -

while kubectl get pods --no-headers -A | grep -v Pending | grep -v Running > /dev/null
do
  watch -g kubectl get pods -A
done

kubectl wait -A --for=condition=Ready pod --all

