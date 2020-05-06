# References
# - https://github.com/ymap-team/ROOT2020/wiki/Install_ROOT_Windows
# - https://qiita.com/jyoppomu/items/f8d6307efb5723fa1694
#

FROM jupyter/datascience-notebook

LABEL maintainer="Kazuki Iwanaga <>"

USER root

RUN DEBIAN_FRONTEND=noninteractive

# Change the location of ripository
# https://github.com/ymap-team/ROOT2020/wiki/Install_ROOT_Windows
RUN sed -i.bak -e 's%http://[^ ]\+%mirror://mirrors.ubuntu.com/mirrors.txt%g' \
    /etc/apt/sources.list && \
    apt-get update
    # apt-get upgrade -y

# Set timezone
RUN apt-get install tzdata -y
ENV TZ=Asia/Tokyo

# ...
# Install CERN/ROOT
# <-

# Install prerequired packages
RUN apt-get install build-essential cmake python3-dev \
            libx11-dev libxpm-dev libxft-dev libxext-dev \
            libglu1-mesa-dev freeglut3-dev libgl2ps-dev \
            libglew-dev libftgl-dev libgsl-dev -y

# Download ROOT sources
WORKDIR /home/jovyan/root_source
RUN wget https://root.cern/download/root_v6.20.04.source.tar.gz && \
    tar zxvf root_v6.20.04.source.tar.gz

# Build ROOT
WORKDIR /home/jovyan/root_source/build
# RUN apt-get install -y libxpm-dev libxft-dev
# https://ameblo.jp/keirin-keimae/entry-12196806251.html
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local/pyroot \
          -DPYTHON=ON \
          -DPYTHON_EXECUTABLE=/opt/conda/bin/python3.7 \
          -DPYTHON_INCLUDE_DIR=/opt/conda/include/python3.7m \
          -DPYTHON_LIBRARY=/opt/conda/lib/libpython3.7m.so \
          ../root-6.20.04 && \
    cmake --build . && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/pyroot -P cmake_install.cmake
# cmake --build . && \
# make -j3

# https://qiita.com/jyoppomu/items/f8d6307efb5723fa1694
ENV ROOTSYS=/usr/local/pyroot
ENV PATH=$ROOTSYS/bin:$PATH
ENV PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
ENV LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH

# ->

USER jovyan
WORKDIR /home/jovyan/notebook
