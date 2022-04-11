#!/bin/bash

# NOTE: this setup script will be executed right before the launcher file inside the container,
#       use it to configure your environment.

# TODO: this should be arch-specific
export OPENBLAS_CORETYPE=ARMV8

# replace python3.8 w/ python3.6 in PYTHONPATH
export PYTHONPATH="${PYTHONPATH//python3.8/python3.6}"

# configure ROS network
export ROS_MASTER_URI=http://10.0.0.10:11311
export ROS_HOSTNAME=backpack.local
# export ROS_HOSTNAME=slin-HP-Spectre.local
# export ROS_HOSTNAME=takumasus.local

# pinocchio
export PATH="/opt/openrobots/bin:$PATH"
export PKG_CONFIG_PATH="/opt/openrobots/lib/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="/opt/openrobots/lib:$LD_LIBRARY_PATH"
export PYTHONPATH="/opt/openrobots/lib/python3.8/site-packages:$PYTHONPATH"
export CMAKE_PREFIX_PATH="/opt/openrobots:$CMAKE_PREFIX_PATH"
