#!/bin/bash
set -euxo pipefail
NAMESPACE=default
kubectl exec -it pod/curl -- /usr/bin/curl "http://socatdump.${NAMESPACE}:8888/get"

