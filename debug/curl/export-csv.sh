#!/bin/bash
set -euxo pipefail
NAMESPACE=monitoring
kubectl exec -it pod/curl -- /usr/bin/curl "http://vmauth-demo.${NAMESPACE}:8427/select/0/prometheus/api/v1/export/csv" -d 'format=__name__,__value__,__timestamp__:unix_s' -d 'match[]=avalanche_metric_mmmmm_0_0'

