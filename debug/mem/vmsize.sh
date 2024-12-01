#!/bin/bash
set -euo pipefail
./podscstatus.sh | jq '.Pod[] | {PodName: .Name, Containers: (.Container[] | {ContainerName: .Name, Name: .Status.Name, VmSize_kB: .Status.VmSize, VmRSS_kB: .Status.VmRSS})}'

