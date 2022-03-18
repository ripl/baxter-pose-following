#!/usr/bin/env bash

set -ex

TORCHVISION_VERSION=0.8.0a0+291f7e2
TORCHVISION_WHEEL_NAME="torchvision-${TORCHVISION_VERSION}-cp36-cp36m-linux_aarch64.whl"

# install TorchVision
echo "Installing TorchVision v${TORCHVISION_VERSION}..."
pip3 install /tmp/assets/${TORCHVISION_WHEEL_NAME}
