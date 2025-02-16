#!/bin/bash
set -euo pipefail
docker run --rm -it --network host victoriametrics/vlogscli:v1.10.1-victorialogs -datasource.url='http://localhost:9428/select/logsql/query'
