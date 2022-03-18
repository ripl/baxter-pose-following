#!/usr/bin/env bash

set -ex

TRTPOSE_VERSION=0.0.1
TRTPOSE_WHEEL_NAME="trt_pose-${TRTPOSE_VERSION}-cp36-cp36m-linux_aarch64.whl"

# install TRTPose
echo "Installing TRTPose v${TRTPOSE_VERSION}..."
pip3 install /tmp/assets/${TRTPOSE_WHEEL_NAME}
