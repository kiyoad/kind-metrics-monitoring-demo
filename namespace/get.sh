#!/bin/bash
set -euo pipefail
sed -ne 's/^ *name: \([A-Za-z0-9_-]*\)/\1/p' $(dirname $0)/namespace.yaml

