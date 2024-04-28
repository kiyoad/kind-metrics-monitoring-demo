#!/bin/bash
set -euxo pipefail

(cd kind && bash -c ./start.sh)
(cd victoriametrics/operator && bash -c ./apply.sh)
(cd victoriametrics/config && bash -c ./apply.sh)
(cd victoriametrics/manifest && bash -c ./apply.sh)
(cd tools/manifest && bash -c ./apply.sh)
(cd prometheus/manifest && bash -c ./apply.sh)
(cd grafana/manifest && bash -c ./apply.sh)

