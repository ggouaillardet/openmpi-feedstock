#!/bin/bash

OPTS=""

if [ "$(uname)" == "Darwin" ]; then
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET="10.9"
    export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    export CXXFLAGS="$CXXFLAGS -stdlib=libc++"
    export LIBRARY_PATH="${PREFIX}/lib"
    if [ -n "$LD_LIBRARY_PATH" ]; then
        export LD_LIBRARY_PATH="${PREFIX}/lib:$LD_LIBRARY_PATH"
    else
        export LD_LIBRARY_PATH="${PREFIX}/lib"
    fi
fi

ls ${PREFIX}/lib

echo 'program test; end program test' > test.f90
gfortran test.f90
otool -L a.out
./a.out

./configure --prefix=${PREFIX} \
            --disable-dependency-tracking \
            LD_LIBRARY_PATH=$LD_LIBRARY_PATH

make -j 4
make check
make install
