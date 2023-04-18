#!/usr/bin/env bash

#####
# Works on Ubuntu 20.04
# This script builds the rvv toolchain. The invocation looks like:
# build-rvv-toolchain.sh <riscv>
# Note: <riscv> should be an absolute path
#
# e.g. ./build-rvv-toolchain.sh /home/john-doe/example-dir/utils/
#
# Note: after building, ensure to add the riscv path to your path e.g.
# export PATH=/home/john-doe/example-dir/utils/riscv/:$PATH
#####

if [ "$#" -lt 1 ]; then
    echo "ERROR: Needs at least 1 argument for <riscv> directory."
    exit 1
fi

RISCV_DIR=${1}

# Installs the necessary packages for running spike, pk, riscv-gnu-toolchain
sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build

git clone https://github.com/riscv-collab/riscv-gnu-toolchain --recursive rvv -b rvv-next
cd rvv 
git checkout da01ba4 
# Need to update to newer branch of rvv-next that supports rvv instructions
mkdir build && cd build
../configure --prefix=$RISCV_DIR --with-arch=rv32imafdv --with-abi=ilp32d
make -j8
