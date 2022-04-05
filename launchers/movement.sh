#!/bin/bash
source /cpk/environment.sh

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
source ${CPK_CODE_DIR}/devel/setup.bash
# cpk-exec rosrun trt_pose pose_tracker.py
# cpk-exec rosrun trt_pose pose_visualizer.py
rosrun pose2movement random_movement.py


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
