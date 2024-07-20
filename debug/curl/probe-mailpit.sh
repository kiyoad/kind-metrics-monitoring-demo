#!/bin/bash
set -euxo pipefail
NAMESPACE=monitoring
kubectl exec -it pod/curl -- /usr/bin/curl -v 'http://demo-prometheus-blackbox-exporter.'${NAMESPACE}'.svc.cluster.local:9115/probe?target=mailpit-demo-nodeport.'${NAMESPACE}'.svc.cluster.local:8025&module=http_2xx'
