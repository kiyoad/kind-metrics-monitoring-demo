#!/bin/bash
set -euo pipefail
tmpfile=$(mktemp)
function rm_tmpfile {
  [[ -f "$tmpfile" ]] && rm -f "$tmpfile"
}
trap rm_tmpfile EXIT
trap 'trap - EXIT; rm_tmpfile; exit -1' INT PIPE TERM
NAMESPACE=$(tee ${tmpfile} | sed -ne "s/ *namespace: *\(.*\)/\1/p" | head -1)
sed -e "s/\.default\.svc\.cluster\.local/\.${NAMESPACE}\.svc\.cluster\.local/" ${tmpfile}
