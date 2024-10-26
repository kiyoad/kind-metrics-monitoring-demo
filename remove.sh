#!/bin/bash
set -euxo pipefail

(cd kind && bash -c ./stop.sh)
(cd kind/storage && rm -rf worker[1234])
