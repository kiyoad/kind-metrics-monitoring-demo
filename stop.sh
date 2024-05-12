#!/bin/bash
set -euxo pipefail

(cd grafana/helm && bash -c ./uninstall.sh)
(cd prometheus/helm && bash -c ./uninstall.sh)
(cd tools/manifest && bash -c ./apply.sh)
(cd victoriametrics/manifest && bash -c ./delete.sh)
(cd victoriametrics/config && bash -c ./delete.sh)
(cd victoriametrics/operator && bash -c ./delete.sh)
(cd kind && bash -c ./delete.sh)

