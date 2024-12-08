#!/bin/bash
set -euo pipefail

usage() {
    echo "Usage: httpdump port host:hostport [directory]"
    exit 1
}

if [[ $# -ne 2 && $# -ne 3 ]]; then
    usage
fi

PORT="$1"
IFS=':' read -r HOST HOSTPORT <<< "$2"
if [[ $# -eq 3 ]]; then
    DIR="$3"
else
    DIR=""
fi

#echo "PORT: $PORT"
#echo "HOST: $HOST"
#echo "HOSTPORT: $HOSTPORT"
#echo "DIR: $DIR"

NGINXCONF=/etc/nginx/conf.d/proxy.conf

cat <<'EOF' > ${NGINXCONF}
server{
    listen LISTENPORT;

    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    location / {
        proxy_pass http://HOSTPORTDIR;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
    }
}
EOF


HOSTPORTDIR=${HOST}:${HOSTPORT}${DIR}
/usr/bin/sed -i -e 's|LISTENPORT|'${PORT}'|' -e 's|HOSTPORTDIR|'${HOSTPORTDIR}'|' ${NGINXCONF}
/usr/bin/rm /etc/nginx/sites-enabled/default

trap "kill -s SIGQUIT \${CHILD}" SIGTERM
/usr/sbin/nginx -g "daemon off;" &
CHILD=$!
wait ${CHILD}
