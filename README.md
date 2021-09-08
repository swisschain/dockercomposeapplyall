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
    - name: deploy
      uses: swisschain/dockercomposeapplyall@master
      env:
        DOCKER_VM_HOST: 'tcp://dev-docker.domain.net:2375'
        ROOT_CA_CERTIFICATE: ${{ secrets.ROOT_CERTIFICATE }}
        CLIENT_CERTIFICATE: ${{ secrets.CLIENT_CERTIFICATE_PUBLIC_KEY }}
        CLIENT_CERTIFICATE_KEY: ${{ secrets.CLIENT_CERTIFICATE_PRIVATE_KEY }}
