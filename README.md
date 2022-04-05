cpk build -H backpack -f


cpk run -H backpack -L realsense --name realsense -- --privileged --net host

cpk run -H backpack -fsM -- --gpus all --net host

cpk run -L movement --name movement -fM -- --net host

cpk run -H backpack -L movement --name movement -fsM -- --net host
