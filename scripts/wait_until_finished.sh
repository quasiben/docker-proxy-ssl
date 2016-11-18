#!/bin/bash

sleep 10

while docker exec -it ssl /bin/bash -c 'ps aux | grep [n]umpy'; do
  sleep 15
  echo "Waiting for conda to finish installing"
done

echo "Done"
