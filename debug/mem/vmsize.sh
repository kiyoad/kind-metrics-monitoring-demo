#!/bin/bash
set -euo pipefail
./podspstatus.sh | jq '.Pod[] | {PodName: .Name, Containers: (.Container[] | {ContainerName: .Name, ProcessList: (.Process[] | {ProcessName: .Name, VmSize_kB: .VmSize, VmRSS_kB: .VmRSS})})}'
