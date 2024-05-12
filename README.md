# kind-metrics-monitoring-demo

Demo of metrics monitoring on a kind(kubernetes) environment.

## Description

A demonstration of combining multiple components to monitor metrics on Kubernetes.
However, since it is a demo, it will be run on kind

## Getting Started

### Dependencies

* kind 0.22.0 or above (CPU >= 2core, Memory >= 8GB)
  * kindest/node:v1.29.2 or above
* kubectl(+kustomize)
* helm
* bash,sed,head,base64,rm,curl,unzip,watch,git

### Installing

```shell
git clone https://github.com/kiyoad/kind-metrics-monitoring-demo.git
```

The namespace in the demo is `monitoring`.

### Executing program

How to start it

1. `$ cd kind-metrics-monitoring-demo`
1. `$ ./start.sh`
   1. Start kind with Calico embedded in the prepared cluster settings.
   2. Prepare a PersistentVolume in the local file system for VMCluster.
   3. If you haven't already, get VictoriaMetrics Operator.
   4. Start VictoriaMetrics Operator.
   5. Register the configuration VMRule and VMAlertmanagerConfig for VictoriaMetrics.
   6. Start VMCluster, VMAuth, VMAlert and VMAlertmanager.
   7. Start node-exporter, kube-state-metrics, mailpit and avalanche.
   8. Start Prometheus.
   9. Start Grafana.


List of ports for browser access

* Grafana: `http://kindhost:3000/` ID:PASS=admin:adminadmin
* Mailpit: `http://kindhost:8025/`
* VMAlert: `http://kindhost:8080/`
* Prometheus: `http://kindhost:9090/`
* Alertmanager: `http://kindhost:9093/`

## License

This project is licensed under the Apache-2.0 License - see the LICENSE file for details

## Acknowledgments

Inspiration, code snippets, etc.

* [kind](https://kind.sigs.k8s.io)
* [Calico: kind multi-node install](https://docs.tigera.io/calico/latest/getting-started/kubernetes/kind)
* [VictoriaMetrics](https://victoriametrics.com)
* [Kubernetes operator for Victoria Metrics](https://github.com/VictoriaMetrics/operator)
* [Prometheus](https://prometheus.io)
* [Grafana](https://grafana.com)
* [Mailpit](https://mailpit.axllent.org)
* [Avalanche](https://github.com/prometheus-community/avalanche)
* Helm
  * [Prometheus](https://github.com/prometheus-community/helm-charts)
  * [Grafana](https://github.com/grafana/helm-charts)

