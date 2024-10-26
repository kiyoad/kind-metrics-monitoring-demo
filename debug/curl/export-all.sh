#!/bin/bash
set -euxo pipefail
NAMESPACE=monitoring
kubectl exec -it pod/curl -- /usr/bin/curl -v "http://vmauth-demo.${NAMESPACE}:8427/select/0/prometheus/api/v1/export" -d 'match[]={__name__!=""}' > export-all.json

