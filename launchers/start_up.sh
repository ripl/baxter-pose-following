#!/bin/bash

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# launching app
rostopic pub -1 /robot/sonar/head_sonar/set_sonars_enabled std_msgs/UInt16 0 &
rosrun baxter_tools tuck_arms.py -u


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE
