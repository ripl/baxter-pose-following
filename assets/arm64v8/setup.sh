#!/usr/bin/env bash

set -ex

CUDA_VERSION=10.2
PYTORCH_VERSION=1.7.0
PYTORCH_WHEEL_NAME="torch-${PYTORCH_VERSION}.cuda.cudnn-cp38-cp38-linux_aarch64.whl"

# install PyTorch
echo "Installing PyTorch v${PYTORCH_VERSION}..."
pip3 install "/tmp/assets/${PYTORCH_WHEEL_NAME}"

# configure nvidia drivers for Jetson Nano boards
mkdir -p /usr/share/egl/egl_external_platform.d/
echo '\
{\
    "file_format_version" : "1.0.0",\
    "ICD" : {\
        "library_path" : "libnvidia-egl-wayland.so.1"\
    }\
}' > /usr/share/egl/egl_external_platform.d/nvidia_wayland.json

mkdir -p /etc/ld.so.conf.d/
touch /etc/ld.so.conf.d/nvidia-tegra.conf
echo "/usr/lib/aarch64-linux-gnu/tegra" >> /etc/ld.so.conf.d/nvidia-tegra.conf
echo "/usr/lib/aarch64-linux-gnu/tegra-egl" >> /etc/ld.so.conf.d/nvidia-tegra.conf
echo "/usr/local/cuda-${CUDA_VERSION}/targets/aarch64-linux/lib" >> /etc/ld.so.conf.d/nvidia.conf

ldconfig
