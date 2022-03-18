#!/usr/bin/env bash

set -ex

TORCH2TRT_VERSION=0.3.0
TORCH2TRT_WHEEL_NAME="torch2trt-${TORCH2TRT_VERSION}-cp36-cp36m-linux_aarch64.whl"

# install Torch2TRT
echo "Installing Torch2TRT v${TORCH2TRT_VERSION}..."
pip3 install /tmp/assets/${TORCH2TRT_WHEEL_NAME}
