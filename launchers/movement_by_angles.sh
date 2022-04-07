#!/bin/bash
source /cpk/environment.sh

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
source ${CPK_CODE_DIR}/devel/setup.bash
cpk-exec rosrun pose2movement pose2joint.py
rosrun pose2movement coords_viz.py


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
