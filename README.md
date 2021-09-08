# dockercomposeapplyall
Apply all docker-compose yamls to docker host
# example of usage in pipeline
name: Deploy Dev

on:
  push:
    branches: [ dev ]

jobs:
  deploy:
    name: deploy
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: ssh deploy
      uses: swisschain/dockercomposeapplyall@master
      env:
        MODE: 'SSH'
        DOCKER_VM_HOST: 'root@<IP>'
        SSH_PRIVATE_KEY: ${{ secrets.DEV_SSH_PRIVATE_KEY }}
        SSH_KNOW_HOST: '<IP> ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTHAyNTYAAAAIbmAAABBBLOVXiO8fOFnTO/tvMyceRutgJ4pbfsyOfiPB1xZjpNVzmuegG3icr1KFJDf8='
    - name: swarm deploy
      uses: swisschain/dockercomposeapplyall@master
      env:
        MODE: 'SWARM'
        DOCKER_VM_HOST: 'tcp://dev-docker.domain.net:2375'
        ROOT_CA_CERTIFICATE: ${{ secrets.ROOT_CERTIFICATE }}
        CLIENT_CERTIFICATE: ${{ secrets.CLIENT_CERTIFICATE_PUBLIC_KEY }}
        CLIENT_CERTIFICATE_KEY: ${{ secrets.CLIENT_CERTIFICATE_PRIVATE_KEY }}
