#!/bin/bash
source /cpk/environment.sh

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
roslaunch realsense2_camera rs_camera.launch \
    depth_width:=424 \
    depth_height:=240 \
    depth_fps:=15 \
    color_width:=424 \
    color_height:=240 \
    color_fps:=15 \
    align_depth:=true


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
