#!/bin/bash

network=inside

docker network ls | grep $network

if [ $? -eq 0 ]; then
    echo "Network exists"
else
    echo "Building internal network"
    docker network create $network --internal --driver=bridge \
               --subnet=192.168.99.0/24 --gateway=192.168.99.1 \
               --ip-range=192.168.99.128/25

fi


docker-compose up --build -d
docker network connect bridge proxy
