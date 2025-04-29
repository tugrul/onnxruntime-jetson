#!/bin/bash
set -e

git config --global --add safe.directory /github/workspace

git submodule update --init --recursive

V=1 VERBOSE=1 ./build.sh --allow_running_as_root --config Release --update --parallel --build --build_wheel \
    --skip_tests  --skip_onnx_tests --use_cuda --cuda_home=/usr/local/cuda --tensorrt_home /usr/lib/aarch64-linux-gnu \
    --cudnn_home=/usr/lib/aarch64-linux-gnu/ --cmake_extra_defines 'CMAKE_CUDA_ARCHITECTURES=53' \
    'onnxruntime_BUILD_UNIT_TESTS=OFF' 'onnxruntime_USE_FLASH_ATTENTION=OFF' 'onnxruntime_USE_MEMORY_EFFICIENT_ATTENTION=OFF' && \
mkdir -p /github/workspace/build-files && cp build/Linux/Release/dist/*.whl /github/workspace/build-files/
