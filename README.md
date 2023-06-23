# Baxter Pose Following

Empower Baxter to follow a person's pose in real time. This image is based on `ripl/baxter-docker:main-amd64`.

## Build

    git clone --recurse-submodules git@github.com:ripl/baxter-pose-following.git && cd baxter-pose-following/
    cpk build

## Run

    cpk run -c bash -X --net host

## Usage

    # Start the RealSense camera
    cpk run -n realsense -L realsense --net host -- --privileged
