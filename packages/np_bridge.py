import numpy as np
from std_msgs.msg import Float32MultiArray, Float64MultiArray, Int8MultiArray, Int16MultiArray, Int32MultiArray, Int64MultiArray, MultiArrayDimension, UInt8MultiArray, UInt16MultiArray, UInt32MultiArray, UInt64MultiArray

to_ros_array_type = {
    np.float32: Float32MultiArray,
    np.float64: Float64MultiArray,
    np.int8: Int8MultiArray,
    np.int16: Int16MultiArray,
    np.int32: Int32MultiArray,
    np.int64: Int64MultiArray,
    np.uint8: UInt8MultiArray,
    np.uint16: UInt16MultiArray,
    np.uint32: UInt32MultiArray,
    np.uint64: UInt64MultiArray,
}
to_ros_array_type = {np.dtype(k): v for k, v in to_ros_array_type.items()}
to_np_array_dtype = {v: k for k, v in to_ros_array_type.items()}


def to_ros_array(np_array):
    ros_array = to_ros_array_type[np_array.dtype]()
    strides = np.cumprod(np_array.shape[::-1])[::-1]
    ros_array.layout.dim = [MultiArrayDimension(label='dim%d' % i, size=np_array.shape[i], stride=strides[i]) for i in range(np_array.ndim)]
    ros_array.data = np_array.reshape(-1).tolist()
    return ros_array


def to_np_array(ros_array):
    dims = [d.size for d in ros_array.layout.dim]
    return np.array(ros_array.data, dtype=to_np_array_dtype[type(ros_array)]).reshape(dims)
