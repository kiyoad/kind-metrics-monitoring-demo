#!/bin/bash
set -euxo pipefail
if ! kubectl version > /dev/null 2> /dev/null ; then
(cd kind && bash -c ./start.sh)
fi
(cd kind && bash -c ./apply.sh)
(cd victoriametrics/operator && bash -c ./apply.sh)
(cd victoriametrics/config && bash -c ./apply.sh)
(cd victoriametrics/manifest && bash -c ./apply.sh)
(cd tools/manifest && bash -c ./apply.sh)
(cd prometheus/manifest && bash -c ./apply.sh)
(cd grafana/manifest && bash -c ./apply.sh)

