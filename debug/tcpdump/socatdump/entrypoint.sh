#!/bin/bash
set -euo pipefail

usage() {
    echo "Usage: socatdump port host:hostport"
    exit 1
}

if [ ! $# -eq 2 ]; then
    usage
fi

PORT="$1"
IFS=':' read -r HOST HOSTPORT <<< "$2"

#echo "PORT: $PORT"
#echo "HOST: $HOST"
#echo "HOSTPORT: $HOSTPORT"
exec /usr/bin/socat TCP-LISTEN:${PORT},fork TCP:${HOST}:${HOSTPORT}
