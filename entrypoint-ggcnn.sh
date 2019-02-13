#!/bin/bash
set -e

# make rosmaster accesible from the host
export ROS_IP=`hostname -i`

source "/opt/ggcnn/setup.bash"

exec "$@"
