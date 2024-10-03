#!/usr/bin/env python
from dataclasses import dataclass
from threading import Thread

import numpy as np
import rospy
import tyro
from baxter_interface import Head, Limb, RobotEnable
from cv_bridge import CvBridge
from human_pose_tracking.msg import TrackedPoses
from np_bridge import to_np_array
from sensor_msgs.msg import CameraInfo


@dataclass
class PoseFollower:
    """Pose Follower Node"""

    pitch: float = 0
    """Pitch angle of the camera (measured in degrees)."""
    yaw: float = 0
    """Yaw angle of the camera (measured in degrees)."""
    reset_timeout: float = 3
    """Timeout (in seconds) before resetting the robot to its neutral position."""

    def main(self):
        pitch = np.deg2rad(self.pitch)
        yaw = np.deg2rad(self.yaw)
        # x->right, y->front, z->up; mirrored along y-axis
        self.c2w = np.array(((1, 0, 0),
                             (0, -1, 0),
                             (0, 0, 1))) \
            @ np.array(((1, 0, 0),
                        (0, 0, 1),
                        (0, -1, 0))) \
            @ np.array(((np.cos(yaw), 0, -np.sin(yaw)),
                        (0, 1, 0),
                        (np.sin(yaw), 0, np.cos(yaw)))) \
            @ np.array(((1, 0, 0),
                        (0, np.cos(pitch), -np.sin(pitch)),
                        (0, np.sin(pitch), np.cos(pitch))))
        limbs = ('left', 'right')
        self.neutral_angles = (0.0, -0.55, 0.0, 0.75, 0.0, 1.26, 0.0)
        self.angles = {limb: [None, list(self.neutral_angles)] for limb in limbs}
        self.cv_bridge = CvBridge()
        rospy.init_node('pose_follower')
        self.K_inv = np.linalg.inv(np.reshape(rospy.wait_for_message('/camera/color/camera_info', CameraInfo).K, (3, 3)))
        RobotEnable().enable()
        Thread(target=Head().set_pan, args=(0,)).start()
        self.limbs = {limb: Limb(limb) for limb in limbs}
        for limb in limbs:
            Thread(target=self.move_limb, args=(limb,), daemon=True).start()
        rospy.Subscriber('/tracked_poses', TrackedPoses, callback=self.pose_callback, queue_size=1)
        rospy.loginfo('Pose Follower Node is Up!')
        rospy.spin()

    def pose_callback(self, data):
        highlight = data.highlight
        if highlight == -1:
            return
        poses = to_np_array(data.poses)[highlight]
        poses[:, -1] = 1
        depths = to_np_array(data.depths)[highlight]
        self.update_angles(self.c2w @ self.K_inv @ poses.T * depths, depths > 0)

    def move_limb(self, limb):
        joint_names = self.limbs[limb].joint_names()
        while True:
            if self.angles[limb][0] is not None and rospy.get_time() - self.angles[limb][0] > self.reset_timeout:
                self.angles[limb] = [None, list(self.neutral_angles)]
            self.limbs[limb].set_joint_positions(dict(list(zip(joint_names, self.angles[limb][1]))))

    def update_angles(self, poses, valids):
        # poses: (3, 17)
        def normalized(vec):
            vec = np.asarray(vec, dtype=float)
            n = np.linalg.norm(vec)
            if not n:
                return None
            return vec / n

        def get_vertical_component(vec, axis, normalize=False):
            axis = normalized(axis)
            if axis is None:
                return None
            vec = vec - np.dot(vec, axis) * axis
            if normalize:
                vec = normalized(vec)
            return vec

        def compute_angle(from_vec, to_vec, rot_axis):
            a = get_vertical_component(from_vec, rot_axis, normalize=True)
            if a is None:
                return None
            b = get_vertical_component(to_vec, rot_axis, normalize=True)
            if b is None:
                return None
            return np.sign(np.dot(np.cross(a, b), rot_axis)) * np.arccos(np.dot(a, b))

        poses = poses.T
        t = rospy.get_time()
        f_l = f_r = False
        if valids[6] and valids[8]:
            l68 = poses[8] - poses[6]
            if np.any(l68):
                l68_xy = (-np.sqrt(3), 1, 0)
                s0 = compute_angle(l68_xy, l68, (0, 0, 1))
                if s0 is None:
                    self.angles['left'][1][0] = 0
                else:
                    self.angles['left'][1][0] = s0
                    l68_xy = get_vertical_component(l68, (0, 0, 1))
                self.angles['left'][1][1] = compute_angle(l68_xy, l68, np.cross(l68_xy, (0, 0, -1)))
                f_l = True
                if valids[10]:
                    l8a = poses[10] - poses[8]
                    if np.any(l8a):
                        e0 = compute_angle(l68_xy if s0 is None else (0, 0, -1), l8a, l68)
                        self.angles['left'][1][2:4] = [0, 0] if e0 is None else [e0, compute_angle(l68, l8a, np.cross(l68, l8a))]
        if valids[5] and valids[7]:
            l57 = poses[7] - poses[5]
            if np.any(l57):
                l57_xy = (np.sqrt(3), 1, 0)
                s0 = compute_angle(l57_xy, l57, (0, 0, 1))
                if s0 is None:
                    self.angles['right'][1][0] = 0
                else:
                    self.angles['right'][1][0] = s0
                    l57_xy = get_vertical_component(l57, (0, 0, 1))
                self.angles['right'][1][1] = compute_angle(l57_xy, l57, np.cross(l57_xy, (0, 0, -1)))
                f_r = True
                if valids[9]:
                    l79 = poses[9] - poses[7]
                    if np.any(l79):
                        e0 = compute_angle(l57_xy if s0 is None else (0, 0, -1), l79, l57)
                        self.angles['right'][1][2:4] = [0, 0] if e0 is None else [e0, compute_angle(l57, l79, np.cross(l57, l79))]
        if f_l:
            self.angles['left'][0] = t
            self.angles['left'][1][-3:] = [0] * 3
        if f_r:
            self.angles['right'][0] = t
            self.angles['right'][1][-3:] = [0] * 3


if __name__ == '__main__':
    tyro.cli(PoseFollower).main()
