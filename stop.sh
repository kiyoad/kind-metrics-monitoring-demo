#!/bin/bash
set -euxo pipefail

(cd grafana/manifest && bash -c ./delete.sh)
(cd prometheus/manifest && bash -c ./delete.sh)
(cd tools/manifest && bash -c ./apply.sh)
(cd victoriametrics/manifest && bash -c ./delete.sh)
(cd victoriametrics/config && bash -c ./delete.sh)
(cd victoriametrics/operator && bash -c ./delete.sh)
(cd kind && bash -c ./stop.sh)

