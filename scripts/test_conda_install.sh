#!/bin/bash

string=`docker exec -it app /bin/bash -c '/opt/miniconda/bin/conda list botod'`

if [[ $string == *"boto"* ]]
then
  echo "Success!";
  echo 0
else
  echo "Failure"
  echo 1
fi

