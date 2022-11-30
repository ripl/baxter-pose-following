# Usage

make sure git-lfs is installed

`git clone --recursive git@github.com:ripl/baxter-pose-demo.git`

## create a cpk remote machine

`cpk machine create backpack ripl@backpack.local`

## build on backpack

make sure `ROS_HOSTNAME` in setup.sh is correct

`cpk build -H backpack -f`

## build locally

make sure `ROS_HOSTNAME` in setup.sh is correct

`cpk build -f`

## start realsense on backpack

`cpk run -H backpack -L realsense --name realsense -fsM -- --privileged --net host`

## start trt pose on backpack

`cpk run -H backpack -fsM -- --gpus all --net host`

## start pose2joint locally

`cpk run -L pose2joint --name pose2joint -fM -- --net host`

## start movement_by_angles locally

`cpk run -L movement_by_angles --name movement_by_angles -fM -- --net host`
