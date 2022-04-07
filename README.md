cpk build -H backpack -f

cpk build -f


cpk run -H backpack -L realsense --name realsense -fsM -- --privileged --net host

cpk run -H backpack -fsM -- --gpus all --net host

cpk run -L movement --name movement -fM -- --net host

cpk run -H backpack -L movement --name movement -fsM -- --net host

cpk run -L bash --name bash -fM -- --net host

cpk run -L movement_by_angles --name movement_by_angles -fM -- --net host
