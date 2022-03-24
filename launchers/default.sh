#!/bin/bash
source /cpk/environment.sh

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
cpk-exec roslaunch realsense2_camera rs_camera.launch
python3.6 $CPK_PROJECT_PATH/packages/trt_pose/src/pose_estimator.py


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
