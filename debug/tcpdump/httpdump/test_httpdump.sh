#!/bin/bash
set -euxo pipefail
NAMESPACE=default
kubectl exec -it pod/curl -- /usr/bin/curl "http://httpdump.${NAMESPACE}:8888/get"

