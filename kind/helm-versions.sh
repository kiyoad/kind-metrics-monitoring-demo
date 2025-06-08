#!/bin/bash
set -euo pipefail
helm search repo $1 --versions | head
