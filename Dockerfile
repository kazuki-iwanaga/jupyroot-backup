FROM jupyter/datascience-notebook

LABEL maintainer="Kazuki Iwanaga <>"

USER root

# Change the location of ripository
RUN sed -i.bak -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' \
    /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y

# Set timezone
RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tzdata
ENV TZ=Asia/Tokyo

# ...
# Install CERN/ROOT
# <-

# Install prerequired packages
RUN apt-get -y install build-essential cmake python3-dev && \
                       libx11-dev libxpm-dev libxft-dev libxext-dev && \
                       libglu1-mesa-dev freeglut3-dev libgl2ps-dev && \
                       libglew-dev libftgl-dev libgsl-dev

# Download ROOT sources
WORKDIR /home/jovyan/root_source
RUN wget https://root.cern/download/root_v6.20.04.source.tar.gz && \
    tar zxvf root_v6.20.04.source.tar.gz

# Build ROOT
WORKDIR /home/jovyan/root_source/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local/pyroot \
          -DPYTHON_EXECUTABLE=/opt/conda/bin/python3.7 \
          -DPYTHON_INCLUDE_DIR=/opt/conda/include/python3.7m \
          -DPYTHON_LIBRARY=/opt/conda/lib/python3.7/config-3.7m-x86_64-linux-gnu \
          ../root-6.20.04 && \
    cmake --build . && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/pyroot -P cmake_install.cmake

ENV ROOTSYS=/usr/local/pyroot
ENV PATH=$ROOTSYS/bin:$PATH
ENV PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
ENV LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH

# ->

USER jovyan
