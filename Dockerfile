FROM tensorflow/tensorflow:1.12.0-gpu

ARG project_dir=/ggcnn/

ADD requirements.txt $project_dir

WORKDIR $project_dir

RUN pip install -r requirements.txt

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update && apt-get install -y ros-kinetic-desktop-full && rm -rf /var/lib/apt/lists/*



