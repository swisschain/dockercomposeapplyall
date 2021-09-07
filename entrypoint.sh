#!/bin/sh

# exit when any command fails
set -e

# Root Cettificate to trust SSL Docker Host
echo "$ROOT_CA_CERTIFICATE" | base64 -d > /tmp/root-ca.crt
# Client Cettificate
echo "$CLIENT_CERTIFICATE" | base64 -d > /tmp/client.crt
# Client Cettificate Private Key
echo "$CLIENT_CERTIFICATE_KEY" | base64 -d > /tmp/client.key

ls -la /tmp

docker version

docker-compose version

docker --host $DOCKER_VM_HOST --tlscacert /tmp/root-ca.crt --tlscert /tmp/client.crt --tlskey /tmp/client.key --tlsverify ps -a
