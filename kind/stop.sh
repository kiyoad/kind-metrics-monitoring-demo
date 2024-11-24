#!/bin/bash
set -euxo pipefail
kind delete cluster
docker stop kind-registry
docker rm kind-registry

