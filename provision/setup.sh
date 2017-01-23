#!/usr/bin/env bash 
set -e

PREFIX=/usr
BUILD_TYPE=Release

# install required deps
sudo apt-get install -y \
    git libjansson-dev cmake g++ \
    libboost-dev libboost-filesystem-dev libboost-system-dev \
    libboost-program-options-dev libjansson-dev \
    libsnappy-dev zlib1g-dev liblzma-dev pkg-config

# clone upstream git repo
[[ -d /tmp/avro ]] || git clone https://github.com/apache/avro.git /tmp/avro
cd /tmp/avro

# use the avro 1.7.7 release
git checkout release-1.7.7

# compile and install required avro shared object from source
cd /tmp/avro/lang/c
[[ -d build ]] || mkdir build
cd build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DTHREADSAFE=true
make
make test
make install

# compile and run example
cd /vagrant/example
gcc quickstop.c -oquickstop -lavro
./quickstop
