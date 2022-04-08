#!/bin/bash
source /cpk/environment.sh
# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
source ${CPK_CODE_DIR}/devel/setup.bash
rosrun pose2movement pose2joint.py


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
