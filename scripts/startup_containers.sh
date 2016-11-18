#!/bin/bash

network="inside"

aa=`docker network ls | grep $network`

if [ $? -eq 0 ]; then
    echo "Network exists"
else
    echo "Building internal network"
    docker network create $network --internal --driver=bridge \
               --subnet=192.168.99.0/24 --gateway=192.168.99.1 \
               --ip-range=192.168.99.128/25

fi

docker-compose up -d

# add ip of SSL container to APP container
#ip=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ssl`
#docker exec -it app bash -c "echo $ip proxy.io >> /etc/hosts"

docker network connect bridge proxy
