#!/bin/bash

OPTS=""

if [ "$(uname)" == "Darwin" ]; then
    export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET="10.9"
    export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    export CXXFLAGS="$CXXFLAGS -stdlib=libc++"
    export LIBRARY_PATH="${PREFIX}/lib"
    export LD_LIBRARY_PATH="${PREFIX}/lib"
fi

ls $DYLD_FALLBACK_LIBRARY_PATH

echo 'program test; end program test' > test.f90
gfortran test.f90
./a.out

./configure --prefix=$PREFIX \
            --disable-dependency-tracking


make -j $CPU_COUNT
make check
make install
