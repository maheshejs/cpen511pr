#!/usr/bin/env bash

#####
# Works on Ubuntu 20.04
# This script builds spike. The invocation looks like:
# build-spike.sh <riscv>
# Note: <riscv> should be an absolute path
#
# e.g. ./build-spike.sh /home/john-doe/example-dir/utils/riscv
#
# Note: after building, ensure to add the riscv path to your path e.g.
# export PATH=/home/john-doe/example-dir/utils/riscv-isa-sim/build/:$PATH
#####

if [ "$#" -lt 1 ]; then
    echo "ERROR: Needs at least 1 argument for <riscv> directory."
    exit 1
fi

RISCV_DIR=${1}

cd ../riscv-isa-sim 
mkdir build && cd build
../configure --prefix=$RISCV_DIR --with-isa=rv32imav
make -j8
make install
