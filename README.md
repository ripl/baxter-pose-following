# Baxter Pose Following

Empower Baxter to follow a person's pose in real time. This image is based on [`ripl/baxter-docker:main`](https://github.com/ripl/baxter-docker).

## Build

```bash
git clone --recurse-submodules https://github.com/ripl/baxter-pose-following.git && cd baxter-pose-following/
cpk build
```

## Run

```bash
# After starting up Baxter
cpk run -L start_up --net host

# Run the demo
cpk run --net host -- --gpus all --privileged

# Before shuting down Baxter
cpk run -L shut_down --net host
```

## Development

```bash
# Start the demo
cpk run -f -M --net host -- --gpus all --privileged
```

```bash
# Start the RealSense camera
cpk run -n realsense -L realsense --net host -- --privileged
# Start pose tracking
cpk run -f -n pose-tracking -L pose_tracking -M --net host -- --gpus all
# Start pose following
cpk run -f -n pose-following -L pose_following -M --net host
```

```bash
# Start the container in interactive mode
cpk run -f -n dev -c bash -M -X --net host -- --gpus all --privileged
# Start the container in detached mode
cpk run -f -n dev -c bash -M -X --net host -d -- --gpus all --privileged
```
