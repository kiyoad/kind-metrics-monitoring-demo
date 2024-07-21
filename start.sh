#!/bin/bash
set -euxo pipefail
if ! kubectl version > /dev/null 2> /dev/null ; then
(cd kind && bash -c ./start.sh)
fi
(cd kind && bash -c ./apply.sh)
(cd namespace && bash -c ./apply.sh)
(cd victoriametrics/operator-helm && bash -c ./install.sh)
(cd victoriametrics/config && bash -c ./apply.sh)
(cd victoriametrics/manifest && bash -c ./apply.sh)
(cd tools/manifest && bash -c ./apply.sh)
(cd prometheus/helm && bash -c ./install.sh)
(cd grafana/helm && bash -c ./install.sh)
(cd kube-state-metrics/helm && bash -c ./install.sh)
(cd prometheus-node-exporter/helm && bash -c ./install.sh)
(cd prometheus-pushgateway/helm && bash -c ./install.sh)
(cd prometheus-blackbox-exporter/helm && bash -c ./install.sh)

