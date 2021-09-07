#!/bin/bash

# exit when any command fails
#set -e

# keep track of the last executed command
#trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
#trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

# Root Cettificate to trust SSL Docker Host
#echo "$ROOT_CA_CERTIFICATE" | base64 --decode > /tmp/root-ca.crt
# Client Cettificate
#echo "$CLIENT_CERTIFICATE" | base64 --decode > /tmp/client.crt
# Client Cettificate Private Key
#echo "$CLIENT_CERTIFICATE_KEY" | base64 --decode > /tmp/client.key

ls -la /tmp

#docker version

#docker-compose version

#docker --host $DOCKER_VM_HOST --tlscacert /tmp/root-ca.crt --tlscert /tmp/client.crt --tlskey /tmp/client.key --tlsverify ps -a
