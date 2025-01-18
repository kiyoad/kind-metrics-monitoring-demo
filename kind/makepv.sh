#!/bin/bash
set -euo pipefail

MAXNODENUM=4
MAXVOLNUM=4
PVCONF=pvconf.yaml
KINDWORKERCONF=kindworkernode.yaml

if [[ -x /opt/homebrew/bin/gsed ]]; then
  SED=/opt/homebrew/bin/gsed
else
  SED=sed
fi

IMAGE=$(${SED} -n -e "s|image: \(.*\)|\\1|p" kindcontrolnode.yaml | xargs)

rm -f ${PVCONF} ${KINDWORKERCONF}
for ((NODENUM = 1; NODENUM <= ${MAXNODENUM}; NODENUM++)); do
  for ((VOLNUM = 1; VOLNUM <= ${MAXVOLNUM}; VOLNUM++)); do

    cat <<EOF >>${PVCONF}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: worker-pv${NODENUM}${VOLNUM}
spec:
  capacity:
    storage: 10Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage${VOLNUM}
  local:
    path: /pv${VOLNUM}
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - kind-worker${NODENUM}
---
EOF
  done

  cat <<EOF >>${KINDWORKERCONF}
  - role: worker
    image: ${IMAGE}
    extraMounts:
EOF

  for ((VOLNUM = 1; VOLNUM <= ${MAXVOLNUM}; VOLNUM++)); do
    cat <<EOF >>${KINDWORKERCONF}
    - hostPath: $(pwd)/storage/worker${NODENUM}/${VOLNUM}
      containerPath: /pv${VOLNUM}
EOF
  done
done

${SED} -i -e "s/kind-worker1/kind-worker/" ${PVCONF}
