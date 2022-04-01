#!/bin/bash
source /cpk/environment.sh

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
source ${CPK_CODE_DIR}/devel/setup.bash
#cpk-exec roslaunch realsense2_camera rs_camera.launch \
#    depth_width:=424 \
#    depth_height:=240 \
#    depth_fps:=15 \
#    color_width:=424 \
#    color_height:=240 \
#    color_fps:=15 \
#    align_depth:=true
cpk-exec rosrun trt_pose pose_estimator.py
cpk-exec rosrun trt_pose pose_tracker.py
rosrun trt_pose pose_visualizer.py


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
