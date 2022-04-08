cpk build -H backpack -f

cpk build -f


cpk run -H backpack -L realsense --name realsense -fsM -- --privileged --gpus all --net host

cpk run -H backpack -fsM -- --gpus all --net host

cpk run -L pose2joint --name pose2joint -fM -- --net host

cpk run -L movement_by_angles --name movement_by_angles -fM -- --net host


cpk run -X -L rviz --name bash -fM -- --net host --privileged
