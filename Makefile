
usage:
	@echo "Usage: make start | stop | remove"

running:
	@ls -ltra .*_running

start: \
	kind_start \
	storage_start \
	namespace_start \
	vmoperator_start \
	vmalert_start \
	vmcluster_start \
	downsample_start \
	mailpit_start \
	prometheus_start \
	grafana_start \
	kube-state-metrics_start \
	node-exporter_start \
	pushgateway_start \
	blackbox-exporter_start
	@echo "Start all pods."

stop: \
	blackbox-exporter_stop \
	pushgateway_stop \
	node-exporter_stop \
	kube-state-metrics_stop \
	grafana_stop \
	prometheus_stop \
	mailpit_stop \
	downsample_stop \
	vmcluster_stop \
	vmalert_stop \
	vmoperator_stop \
	namespace_stop \
	storage_stop \
	kind_stop
	@echo "Stop all pods."

remove: kind_remove
	@echo "Stop 'kind' and cleanup storage."

avalanche-only_start: \
	kind_start \
	storage_start \
	namespace_start \
	vmoperator_start \
	vmalert_start \
	vmcluster_start \
	downsample_start \
	prometheus_avalanche_only_start \
	grafana_start \
	avalanche_start
	@echo "Start avalanche only."

avalanche-only_stop: \
	avalanche_stop \
	grafana_stop \
	prometheus_avalanche_only_stop \
	downsample_stop \
	vmcluster_stop \
	vmalert_stop \
	vmoperator_stop \
	namespace_stop \
	storage_stop \
	kind_stop
	@echo "Stop avalanche only."

minimum_start: \
	kind_start \
	storage_start \
	namespace_start \
	vmoperator_start
	@echo "Start minimum."

minimum_stop: \
	vmoperator_stop \
	namespace_stop \
	storage_stop \
	kind_stop
	@echo "Stop minimum."

# kind

kind_start:
	@kubectl version > /dev/null 2> /dev/null || ((cd kind && bash -c ./start.sh) && echo "Start 'kind'.")

kind_stop:
	@echo "'kind' is still running. use 'make kind_remove' instead."

kind_remove:
	@(cd kind && bash -c ./stop.sh)
	@(cd kind/storage && sudo rm -rf worker[1234])

# storage

storage_start:
	@[ -f .storage_running ] || ((cd kind && bash -c ./apply.sh) && touch .storage_running)

storage_stop:
	@[ -f .storage_running ] && (cd kind && bash -c ./delete.sh) && rm -f .storage_running || true

# namespace

namespace_start:
	@[ -f .namespace_running ] || ((cd namespace && bash -c ./apply.sh) && touch .namespace_running)

namespace_stop:
	@[ -f .namespace_running ] && (cd namespace && bash -c ./delete.sh) && rm -f .namespace_running || true

# VictoriaMetrics
## Operator

vmoperator_start: namespace_start
	@[ -f .vmoperator_running ] || ((cd victoriametrics/operator-helm && bash -c ./install.sh)  && touch .vmoperator_running)

vmoperator_stop:
	@[ -f .vmoperator_running ] && (cd victoriametrics/operator-helm && bash -c ./uninstall.sh) && rm -f .vmoperator_running || true

## VMAlert

vmalert_start: vmoperator_start storage_start
	@[ -f .vmalert_running ] || ((cd victoriametrics/alerts && bash -c ./apply.sh) && touch .vmalert_running)

vmalert_stop:
	@[ -f .vmalert_running ] && (cd victoriametrics/alerts && bash -c ./delete.sh) && rm -f .vmalert_running || true

## VMInsert,VMStorage,VMSelect,VMAuth

vmcluster_start: vmoperator_start storage_start
	@[ -f .vmcluster_running ] || ((cd victoriametrics/manifest && bash -c ./apply.sh) && touch .vmcluster_running)

vmcluster_stop:
	@[ -f .vmcluster_running ] && (cd victoriametrics/manifest && bash -c ./delete.sh) && rm -f .vmcluster_running || true

## VMAgent

downsample_start: vmoperator_start storage_start
	@[ -f .downsample_running ] || ((cd victoriametrics/downsampling && bash -c ./apply.sh) && touch .downsample_running)

downsample_stop:
	@[ -f .downsample_running ] && (cd victoriametrics/downsampling && bash -c ./delete.sh) && rm -f .downsample_running || true

# Mailpit

mailpit_start: namespace_start
	@[ -f .mailpit_running ] || ((cd mailpit/manifest && bash -c ./apply.sh) && touch .mailpit_running)

mailpit_stop:
	@[ -f .mailpit_running ] && (cd mailpit/manifest && bash -c ./delete.sh) && rm -f .mailpit_running || true

# Prometheus

prometheus_start: namespace_start
	@[ -f .prometheus_running ] || ((cd prometheus/helm && bash -c ./install.sh)  && touch .prometheus_running)

prometheus_stop:
	@[ -f .prometheus_running ] && (cd prometheus/helm && bash -c ./uninstall.sh) && rm -f .prometheus_running || true

prometheus_avalanche_only_start: namespace_start
	@[ -f .prometheus_avalanche_only_running ] || ((cd prometheus/avalanche-only-helm && bash -c ./install.sh)  && touch .prometheus_avalanche_only_running)

prometheus_avalanche_only_stop:
	@[ -f .prometheus_avalanche_only_running ] && (cd prometheus/avalanche-only-helm && bash -c ./uninstall.sh) && rm -f .prometheus_avalanche_only_running || true

# Grafana

grafana_start: namespace_start
	@[ -f .grafana_running ] || ((cd grafana/helm && bash -c ./install.sh)  && touch .grafana_running)

grafana_stop:
	@[ -f .grafana_running ] && (cd grafana/helm && bash -c ./uninstall.sh) && rm -f .grafana_running || true

# Kube state metrics

kube-state-metrics_start: namespace_start
	@[ -f .kube-state-metrics_running ] || ((cd kube-state-metrics/helm && bash -c ./install.sh)  && touch .kube-state-metrics_running)

kube-state-metrics_stop:
	@[ -f .kube-state-metrics_running ] && (cd kube-state-metrics/helm && bash -c ./uninstall.sh) && rm -f .kube-state-metrics_running || true

# Node exporter

node-exporter_start: namespace_start
	@[ -f .node-exporter_running ] || ((cd prometheus-node-exporter/helm && bash -c ./install.sh)  && touch .node-exporter_running)

node-exporter_stop:
	@[ -f .node-exporter_running ] && (cd prometheus-node-exporter/helm && bash -c ./uninstall.sh) && rm -f .node-exporter_running || true

# Pushgateway

pushgateway_start: namespace_start
	@[ -f .pushgateway_running ] || ((cd prometheus-pushgateway/helm && bash -c ./install.sh)  && touch .pushgateway_running)

pushgateway_stop: 
	@[ -f .pushgateway_running ] && (cd prometheus-pushgateway/helm && bash -c ./uninstall.sh) && rm -f .pushgateway_running || true

# Blackbox exporter

blackbox-exporter_start: namespace_start
	@[ -f .blackbox-exporter_running ] || ((cd prometheus-blackbox-exporter/helm && bash -c ./install.sh)  && touch .blackbox-exporter_running)

blackbox-exporter_stop:
	@[ -f .blackbox-exporter_running ] && (cd prometheus-blackbox-exporter/helm && bash -c ./uninstall.sh) && rm -f .blackbox-exporter_running || true

# Avalanche

avalanche_start: namespace_start
	@[ -f .avalanche_running ] || ((cd avalanche/manifest && bash -c ./apply.sh) && touch .avalanche_running)

avalanche_stop:
	@[ -f .avalanche_running ] && (cd avalanche/manifest && bash -c ./delete.sh) && rm -f .avalanche_running || true

