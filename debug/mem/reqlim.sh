#!/bin/bash
set -uo pipefail

NAMESPACE=monitoring
kubectl get pods -n ${NAMESPACE} -o jsonpath="{range .items[*]}Pod: {.metadata.name}{'\n'}{range .spec.containers[*]}Container: {.name}, Requests: {.resources.requests}, Limits: {.resources.limits}{'\n'}{end}{'\n'}{end}"
