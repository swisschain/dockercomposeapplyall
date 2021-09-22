#!/bin/sh

# exit when any command fails
set -e

case $MODE in

  SSH)
    echo create ssh dir
    mkdir ~/.ssh
    echo create ssh key
    echo $SSH_PRIVATE_KEY | base64 -d > ~/.ssh/id_rsa
    chmod 400 ~/.ssh/id_rsa
    echo create ssh know host file
    echo $SSH_KNOW_HOST > ~/.ssh/known_hosts
    echo run command
    #ssh -i ~/.ssh/id_rsa $DOCKER_VM_HOST docker-compose -f $SERVICE_YAML_FILE up -d
    ssh -i ~/.ssh/id_rsa -o UserKnownHostsFile=~/.ssh/known_hosts $DOCKER_VM_HOST docker-compose -f $SERVICE_YAML_FILE up -d
    #ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no $DOCKER_VM_HOST pwd
    #ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no $DOCKER_VM_HOST ls -la 
    #ssh $DOCKER_VM_HOST << EOF
    #  hostname
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

