#!/bin/bash
set -euxo pipefail
NAMESPACE=monitoring
kubectl exec -it pod/curl -- /usr/bin/curl "http://vmauth-demo.${NAMESPACE}:8427/select/0/prometheus/api/v1/series" -d 'match[]=avalanche_metric_mmmmm_0_0' | jq .
