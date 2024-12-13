#!/bin/bash
set -euo pipefail
./onepodpstatus.sh "$@" | jq '.Container[] | {ContainerName: .Name, ProcessList: (.Process[] | {ProcessName: .Name, VmSize_kB: .VmSize, VmRSS_kB: .VmRSS})}'
