#!/bin/bash
set -euxo pipefail
cat <<EOF | kubectl exec -i pod/curl -- /usr/bin/curl -v --data-binary @- "http://demo-prometheus-pushgateway.monitoring:9091/metrics/job/some_job/instance/some_instance"
# TYPE some_metric counter
some_metric{label="val1"} 42
# TYPE another_metric gauge
# HELP another_metric Just an example.
another_metric 2398.283
EOF
#
# another_metric{instance="some_instance", job="some_job"} 2398.283
# push_failure_time_seconds{instance="some_instance", job="some_job"} 0
# push_time_seconds{instance="some_instance", job="some_job"} 1740299208.0887928
# some_metric{instance="some_instance", job="some_job", label="val1"} 42
#
