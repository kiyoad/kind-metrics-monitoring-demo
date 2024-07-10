#!/bin/bash
set -euxo pipefail

date
sleep 900
kubectl get pods -n monitoring -o wide
docker pause kind-worker

date
sleep 900
kubectl get pods -n monitoring -o wide
docker unpause kind-worker

date
sleep 900
kubectl get pods -n monitoring -o wide
docker pause kind-worker2

date
sleep 900
kubectl get pods -n monitoring -o wide
docker unpause kind-worker2

date
sleep 900
kubectl get pods -n monitoring -o wide
docker pause kind-worker3

date
sleep 900
kubectl get pods -n monitoring -o wide
docker unpause kind-worker3

date
sleep 900
kubectl get pods -n monitoring -o wide
docker pause kind-worker4

date
sleep 900
kubectl get pods -n monitoring -o wide
docker unpause kind-worker4

date
sleep 900
kubectl get pods -n monitoring -o wide

