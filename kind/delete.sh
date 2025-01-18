#!/bin/bash
set -euxo pipefail
kubectl delete -f pvconf.yaml --timeout=10s || true
