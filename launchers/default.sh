#!/bin/bash

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
roslaunch realsense2_camera rs_camera.launch align_depth:=true &
rosrun human_pose_tracking pose_estimator.py &
rosrun human_pose_tracking pose_tracker.py &
rosrun human_pose_tracking pose_visualizer.py &
rosrun baxter_pose_following pose_follower.py


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
