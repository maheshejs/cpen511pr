#!/usr/bin/env bash

#####
# Works on Ubuntu 20.04
# This script builds pk. The invocation looks like:
# build-pk.sh <riscv>
# Note: <riscv> should be an absolute path
#
# e.g. ./build-pk.sh /home/john-doe/example-dir/utils/riscv
#
# Note: after building, ensure to add the riscv path to your path e.g.
# export PATH=/home/john-doe/example-dir/utils/riscv-pk/build/:$PATH
#####

if [ "$#" -lt 1 ]; then
    echo "ERROR: Needs at least 1 argument for <riscv> directory."
    exit 1
fi

RISCV_DIR=${1}

git clone https://github.com/riscv-software-src/riscv-pk.git
cd riscv-pk; 
git checkout 2efabd3 
mkdir build; cd build
../configure --prefix=$RISCV_DIR --host=riscv32-unknown-elf --with-arch=rv32imafdv
make -j8
make install
