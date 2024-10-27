#!/bin/bash
set -euxo pipefail

(cd avalanche/manifest && bash -c ./delete.sh)
(cd grafana/helm && bash -c ./uninstall.sh)
(cd prometheus/avalanche-only-helm && bash -c ./uninstall.sh)
(cd victoriametrics/downsampling && bash -c ./delete.sh)
(cd victoriametrics/manifest && bash -c ./delete.sh)
(cd victoriametrics/operator-helm && bash -c ./uninstall.sh)
(cd namespace && bash -c ./delete.sh)
(cd kind && bash -c ./delete.sh)

