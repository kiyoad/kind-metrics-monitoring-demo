#!/bin/bash
set -euxo pipefail

(cd prometheus-blackbox-exporter/helm && bash -c ./uninstall.sh)
(cd prometheus-pushgateway/helm && bash -c ./uninstall.sh)
(cd prometheus-node-exporter/helm && bash -c ./uninstall.sh)
(cd kube-state-metrics/helm && bash -c ./uninstall.sh)
(cd grafana/helm && bash -c ./uninstall.sh)
(cd prometheus/helm && bash -c ./uninstall.sh)
(cd mailpit/manifest && bash -c ./delete.sh)
(cd victoriametrics/downsampling && bash -c ./delete.sh)
(cd victoriametrics/manifest && bash -c ./delete.sh)
(cd victoriametrics/config && bash -c ./delete.sh)
(cd victoriametrics/operator-helm && bash -c ./uninstall.sh)
(cd namespace && bash -c ./delete.sh)
(cd kind && bash -c ./delete.sh)

