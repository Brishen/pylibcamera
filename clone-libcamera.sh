#!/bin/bash

rm -rf libcamera
rm -rf subprojects/libcamera
mkdir -p subprojects

git clone $1 subprojects/libcamera
pushd subprojects/libcamera

git checkout $2
git apply ../../$3.patch

popd
