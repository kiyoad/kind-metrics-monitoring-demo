#!/bin/bash
set -euo pipefail

MAXNODENUM=4
MAXVOLNUM=4
NODE1=(1 1 1 0)
NODE2=(1 1 1 0)
NODE3=(1 1 0 0)
NODE4=(0 0 0 1)
IFS=' ' read -r -a NODEMATRIX <<<"${NODE1[*]} ${NODE2[*]} ${NODE3[*]} ${NODE4[*]}"

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
    INDEX=$(((NODENUM - 1) * MAXNODENUM + (VOLNUM - 1)))
    if [[ "${NODEMATRIX[$INDEX]}" == "1" ]]; then
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
    fi
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
