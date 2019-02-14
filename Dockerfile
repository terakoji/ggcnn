FROM tensorflow/tensorflow:1.12.0-gpu

ADD requirements.txt $project_dir

RUN pip install -r requirements.txt

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update && apt-get install -y ros-kinetic-desktop-full && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /ggcnn_ws/src
ADD ggcnn_kinova_grasping /ggcnn_ws/src
ADD entrypoint.sh /
ADD entrypoint-ggcnn.sh /
RUN cd /ggcnn_ws/src && /entrypoint.sh catkin_init_workspace
RUN cd /ggcnn_ws && /entrypoint.sh catkin_make install -DCMAKE_INSTALL_PREFIX=/opt/ggcnn

ADD epoch_29_model.hdf5 /opt/ggcnn

ENV HOME "/root"
ENV ROS_HOME "/root/.ros"
CMD /entrypoint-ggcnn.sh rosrun ggcnn_kinova_grasping run_ggcnn.py



