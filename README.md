# kind-metrics-monitoring-demo

Demo of metrics monitoring on a kind(kubernetes) environment.

## Description

A demonstration of combining multiple components to monitor metrics on Kubernetes.
However, since it is a demo, it will be run on kind

## Getting Started

### Dependencies

* kind 0.27.0 or above (CPU >= 2core, Memory >= 8GB)
  * kindest/node:v1.32.2 or above
* kubectl(+kustomize)
* helm
* bash,sed,head,base64,rm,curl,unzip,watch,git,GNU make

### Installing

```shell
git clone https://github.com/kiyoad/kind-metrics-monitoring-demo.git
```

The namespace in the demo is `monitoring`.

### Executing program

How to start it

1. `$ cd kind-metrics-monitoring-demo`
1. `$ make ready`
   * Get some container images to register in the local registry (first time only).
      * See the text file `kind/images.lst`
1. `$ make start`
   1. Start kind ~~with Calico embedded in the prepared cluster settings~~.
   2. Prepare a PersistentVolume in the local file system.
   3. Start VictoriaMetrics Operator.
   4. Start VictoriaLogs and Fluent Bit.
   5. Start VMCluster, VMAuth, VMAlert, VMAlertmanager and VMAgent.
   6. Start mailpit.
   7. Start Prometheus and Grafana.
   8. Start node-exporter, kube-state-metrics, pushgateway and blackbox-exporter.

List of ports for browser access

* Grafana: `http://kindhost:3000/` ID:PASS=admin:adminadmin
* Mailpit: `http://kindhost:8025/`
* VMAlert: `http://kindhost:8080/`
* Prometheus: `http://kindhost:9090/`
* Pushgateway: `http://kindhost:9091/`
* Alertmanager: `http://kindhost:9093/`
* VMUI(VictoriaMetrics): `http://kindhost:8427/select/0/vmui/`
* VMUI(VictoriaLogs): `http://kindhost:9428/select/vmui/`

## Known issues

* Too Many Open Files
  * kube-proxy or fluent-bit may not start due to the above error.
  * Increasing the value of `fs.inotify.max_user_instances` in the following setting may solve the problem.
    * `$ sudo sysctl fs.inotify.max_user_instances=1024`
    * `$ sudo sysctl -p`
* Running Inside a Proxy Environment
  * To run the demo in an environment that requires a proxy, add the following to the NO_PROXY (or no_proxy) environment variable:
    * `kind-registry`

## License

This project is licensed under the Apache-2.0 License - see the LICENSE file.

## Acknowledgments

Inspiration, code snippets, etc.

* [kind](https://kind.sigs.k8s.io)
* ~~[Calico: kind multi-node install](https://docs.tigera.io/calico/latest/getting-started/kubernetes/kind)~~
* [VictoriaMetrics](https://victoriametrics.com)
* [Kubernetes operator for Victoria Metrics](https://github.com/VictoriaMetrics/operator)
* [Prometheus](https://prometheus.io)
* [Grafana](https://grafana.com)
* [Mailpit](https://mailpit.axllent.org)
* [Avalanche](https://github.com/prometheus-community/avalanche)
* [Fluent Bit](https://fluentbit.io/)
* Helm
  * [VictoriaMetrics](https://github.com/VictoriaMetrics/helm-charts)
  * [Prometheus](https://github.com/prometheus-community/helm-charts)
  * [Grafana](https://github.com/grafana/helm-charts)
  * [Fluent](https://github.com/fluent/helm-charts)
