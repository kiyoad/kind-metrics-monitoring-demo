#!/bin/bash
set -euo pipefail
curl -fsSLO  https://github.com/VictoriaMetrics/operator/releases/download/v0.42.4/bundle_crd.zip
rm -rf ./release
unzip bundle_crd.zip
