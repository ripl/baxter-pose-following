#!/usr/bin/env bash

set -ex

# install miscellaneous dependencies
pip3.6 install tqdm cython pycocotools
apt install --no-install-recommends -y python3-matplotlib

TRTPOSE_VERSION=0.0.1
TRTPOSE_WHEEL_NAME="trt_pose-${TRTPOSE_VERSION}-cp36-cp36m-linux_aarch64.whl"

# install TRTPose
echo "Installing TRTPose v${TRTPOSE_VERSION}..."
pip3.6 install /tmp/assets/${TRTPOSE_WHEEL_NAME}
