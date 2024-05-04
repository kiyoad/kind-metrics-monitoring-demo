#!/bin/bash
set -euxo pipefail
kubectl delete -f pv.yaml --timeout=10s || /usr/bin/true

