#!/usr/bin/env bash

set -ex

CUDA_VERSION=10.2

# add a fake pip3.6
cp /tmp/assets/pip3.6 /usr/local/bin/pip3.6

# switch to python3.6
update-alternatives --install \
    /usr/bin/python3 python3 "$(which python3.6)" 1
update-alternatives --install \
    /usr/local/bin/pip3 pip3 "$(which pip3.6)" 1

# remove system-level python libraries
pip3 uninstall -y pillow numpy
rm -rf /usr/lib/python3/dist-packages/PIL*
rm -rf /usr/lib/python3/dist-packages/numpy*

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
