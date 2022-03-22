#!/usr/bin/env bash

set -ex

CUDA_VERSION=10.2
PYTORCH_VERSION=1.7.0a0
PYTORCH_WHEEL_NAME="torch-${PYTORCH_VERSION}-cp36-cp36m-linux_aarch64.whl"

# install the dependencies
apt install --no-install-recommends -y \
    libjpeg-dev \
    libomp-dev \
    libopenblas-dev \
    libopenmpi-dev
pip3.6 install --target=/usr/local/lib/python3.6/dist-packages \
    Cython \
    future \
    mock \
    numpy \
    pillow \
    setuptools==58.3.0 \
    testresources \
    wheel

# install PyTorch
echo "Installing PyTorch v${PYTORCH_VERSION}..."
pip3.6 install /tmp/assets/${PYTORCH_WHEEL_NAME}
