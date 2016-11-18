#!/bin/bash

set -e
set -x

string=`docker exec -it app /bin/bash -c '/opt/miniconda/bin/conda list boto'`

if [[ $string == *"boto"* ]]
then
  echo "Success!";
  exit 0
else
  echo "Failure"
  exit 1
fi

