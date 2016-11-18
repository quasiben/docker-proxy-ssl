#!/bin/bash

sleep 5
service nginx restart

http_proxy=proxy:8888 https_proxy=proxy:8888 /opt/miniconda/bin/conda install numpy conda-build boto ipython

pushd /opt/miniconda/pkgs
/opt/miniconda/bin/conda index
mkdir /opt/miniconda/linux-64
cp -rf * /opt/miniconda/linux-64

pushd /opt/miniconda/
python -m SimpleHTTPServer 8080
