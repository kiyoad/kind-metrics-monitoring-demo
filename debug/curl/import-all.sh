#!/bin/bash
set -euxo pipefail
NAMESPACE=monitoring
kubectl cp ${1} default/curl:/home/curl_user/data.json
kubectl exec -it pod/curl -- /usr/bin/curl -v -X POST "http://vmauth-demo.${NAMESPACE}:8427/insert/0/prometheus/api/v1/import" -T data.json
kubectl exec pod/curl -- /bin/rm data.json

