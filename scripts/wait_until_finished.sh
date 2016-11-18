#!/bin/bash

set -e
set -x

sleep 10

while docker exec -it ssl /bin/bash -c 'ps aux | grep [n]umpy'; do
  sleep 10
  echo "Waiting for conda to finish installing"
done

# wait until conda index has finished and pkgs are being served
status_code=`docker exec -it app /bin/bash -c 'curl -s -o /dev/null -w "%{http_code}" https://proxy.io/linux-64/repodata.json'`

while true
do
    if [ "$status_code" -eq "200" ]; then
       echo "Conda Packages are now being served"
       break
    else
       sleep 4
       echo "Waiting for conda index to complete"
       status_code=`docker exec -it app /bin/bash -c 'curl -s -o /dev/null -w "%{http_code}" https://proxy.io/linux-64/repodata.json'`
    fi
done

echo "Done"
