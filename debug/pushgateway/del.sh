#!/bin/bash
set -euxo pipefail
kubectl exec pod/curl -- /usr/bin/curl -v -X DELETE "http://demo-prometheus-pushgateway.monitoring:9091/metrics/job/some_job/instance/some_instance"
