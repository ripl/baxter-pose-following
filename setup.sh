#!/bin/bash

# NOTE: this setup script will be executed right before the launcher file inside the container,
#       use it to configure your environment.

# TODO: this should be arch-specific
export OPENBLAS_CORETYPE=ARMV8

# replace python3.8 w/ python3.6 in PYTHONPATH
export PYTHONPATH="${PYTHONPATH//python3.8/python3.6}"
