#!/bin/sh

# exit when any command fails
set -e

case $MODE in

  SSH)
    echo create ssh key
    echo $SSH_PRIVATE_KEY | base64 -d > /id_rsa
    chmod 400 /id_rsa
    echo create ssh know host file
    echo $SSH_KNOW_HOST > /known_hosts
    echo run command
    ssh -i /id_rsa -o UserKnownHostsFile=/known_hosts $DOCKER_VM_HOST docker-compose -f $SERVICE_YAML_FILE up -d
    #ssh -i /id_rsa -o UserKnownHostsFile=/known_hosts $DOCKER_VM_HOST << 'EOF'
    #   hostname
    #   docker-compose -f $SERVICE_YAML_FILE up -d
    #EOF
    ;;

  SWARM)
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

    ls -la 

    cd Seq

    docker-compose --host $DOCKER_VM_HOST --tlscacert /tmp/root-ca.crt --tlscert /tmp/client.crt --tlskey /tmp/client.key --tlsverify config
    docker-compose --host $DOCKER_VM_HOST --tlscacert /tmp/root-ca.crt --tlscert /tmp/client.crt --tlskey /tmp/client.key --tlsverify ps -a
    ;;

  *)
    echo 'Set MODE variable please'
    ;;
esac

