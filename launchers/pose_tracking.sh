#!/bin/bash

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
rosrun human_pose_tracking pose_estimator.py &
rosrun human_pose_tracking pose_tracker.py &
rosrun human_pose_tracking pose_visualizer.py


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
