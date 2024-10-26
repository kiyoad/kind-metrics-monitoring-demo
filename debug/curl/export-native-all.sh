#!/bin/bash
set -euxo pipefail
NAMESPACE=monitoring
kubectl exec -it pod/curl -- /usr/bin/curl "http://vmauth-demo.${NAMESPACE}:8427/select/0/prometheus/api/v1/export/native" -d 'match[]={__name__=~".*"}' --output export-native-all.bin
kubectl cp default/curl:/home/curl_user/export-native-all.bin export-native-all.bin
kubectl exec pod/curl -- /bin/rm export-native-all.bin

