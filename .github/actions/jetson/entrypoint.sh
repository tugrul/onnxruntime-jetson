#!/bin/bash
set -e

git config --global --add safe.directory /github/workspace

git submodule update --init --recursive

./build.sh \
    --allow_running_as_root \
    --config Release \
    --skip_tests \
    --skip_onnx_tests \
    --build_wheel \
    --use_cuda \
    --cuda_home=/usr/local/cuda-10.2 \
    --cudnn_home=/usr/lib/aarch64-linux-gnu/ \
    --parallel \
    --update --build --build_wheel && \
mkdir -p /github/workspace/build-files && \
cp build/Linux/Release/dist/*.whl /github/workspace/build-files/

