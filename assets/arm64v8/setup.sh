#!/usr/bin/env bash

set -ex

CUDA_VERSION=10.2
PYTORCH_VERSION=1.7.0a0
TORCHVISION_VERSION=0.8.0a0+291f7e2
PYTORCH_WHEEL_NAME="torch-${PYTORCH_VERSION}-cp36-cp36m-linux_aarch64.whl"
TORCHVISION_WHEEL_NAME="torchvision-${TORCHVISION_VERSION}-cp36-cp36m-linux_aarch64.whl"

# add a fake pip3.6
cp /tmp/assets/pip3.6 /usr/local/bin/pip3.6

# switch to python3.6
update-alternatives \
    --install /usr/bin/python3 python3 "$(which python3.6)" 1

# install PyTorch
echo "Installing PyTorch v${PYTORCH_VERSION}..."

# remove system-level python libraries
pip3 uninstall -y pillow numpy

# install the dependencies (if not already onboard)
apt install --no-install-recommends -y \
    libjpeg-dev \
    libopenblas-dev \
    libopenmpi-dev \
    libomp-dev
pip3.6 install future wheel mock pillow numpy testresources setuptools==58.3.0 Cython
# install PyTorch 1.7.0
pip3.6 install /tmp/assets/${PYTORCH_WHEEL_NAME}


# install TorchVision
echo "Installing TorchVision v${TORCHVISION_VERSION}..."

apt install --no-install-recommends -y \
    libjpeg-dev \
    zlib1g-dev \
    libpython3-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev
# install TorchVision 0.8.0
pip3.6 install /tmp/assets/${TORCHVISION_WHEEL_NAME}


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
