#!/bin/bash
set -euxo pipefail
if ! kubectl version > /dev/null 2> /dev/null ; then
(cd kind && bash -c ./start.sh)
fi
(cd kind && bash -c ./apply.sh)
(cd namespace && bash -c ./apply.sh)
(cd victoriametrics/operator-helm && bash -c ./install.sh)
(cd victoriametrics/manifest && bash -c ./apply.sh)
(cd victoriametrics/downsampling && bash -c ./apply.sh)
(cd prometheus/avalanche-only-helm && bash -c ./install.sh)
(cd grafana/helm && bash -c ./install.sh)
(cd avalanche/manifest && bash -c ./apply.sh)

