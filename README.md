# Baxter Pose Following

Empower Baxter to follow a person's pose in real time. This image is based on [`ripl/baxter-docker:main`](https://github.com/ripl/baxter-docker).

## Build

```bash
git clone --recurse-submodules git@github.com:ripl/baxter-pose-following.git && cd baxter-pose-following/
cpk build
```

## Run

```bash
# Start the demo
cpk run --net host -- --gpus all --privileged
```

## Development

```bash
# Start the RealSense camera
cpk run -n realsense -L realsense --net host -- --privileged
# Start pose tracking
cpk run -f -n pose-tracking -L pose_tracking -M --net host -- --gpus all
# Start pose following
cpk run -f -n pose-following -L pose_following -M --net host
# Run the container in interactive mode
cpk run -f -n dev -c bash -M -X --net host -- --gpus all --privileged
# Run the container in detached mode
cpk run -f -n dev -c bash -M -X --net host -d -- --gpus all --privileged
```
