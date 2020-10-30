# Ben changed from cuda 10.2 to 10.1 to match his system 
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
WORKDIR /
COPY . .
#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
#    && mv sources.list /etc/apt/ \
#    && rm /etc/apt/sources.list.d/cuda.list \
#    && rm /etc/apt/sources.list.d/nvidia-ml.list \
#    && apt-get update
run apt-get update
RUN apt-get install -y \
    cmake \
    clang \
    git \
    unzip \
    build-essential \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    mesa-common-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libdc1394-22-dev \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log
ENV OPENCV_VERSION="4.3.0"
RUN unzip /opencv-${OPENCV_VERSION}.zip \
    && unzip /opencv_contrib-${OPENCV_VERSION}.zip \
    && unzip /Video_Codec_SDK_9.1.23.zip \
    && mkdir /opencv-${OPENCV_VERSION}/build \
    && cd /opencv-${OPENCV_VERSION}/build \
    && cp /Video_Codec_SDK_9.1.23/include/cuviddec.h /usr/include \
    && cp /Video_Codec_SDK_9.1.23/include/nvcuvid.h /usr/include \
    && cmake -D CMAKE_BUILD_TYPE=Release \
        -D ENABLE_CXX11=1 \
        -D WITH_IPP=ON \
        -D WITH_WEBP=OFF \
        -D BUILD_opencv_python3=no \
        -D BUILD_opencv_python2=no \
        -D WITH_QT=OFF \
        -D OPENCV_FORCE_3RDPARTY_BUILD=ON \
        -D WITH_CUDA=ON \
        -D BUILD_opencv_dnn=OFF \
        -D WITH_NVCUVID=OFF \
        -D WITH_OPENMP=ON \
        -D INSTALL_TESTS=ON \
        -D ENABLE_FAST_MATH=ON \
        -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib-4.3.0/modules \
        -D WITH_EIGEN=yes \
        -D WITH_CUDNN=yes \
        -D BUILD_opencv_cudacodec=yes \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        .. \
    && make -j6 \
    && make install
RUN rm /opencv-${OPENCV_VERSION}.zip \
    && rm /opencv_contrib-${OPENCV_VERSION}.zip \
    && rm /Video_Codec_SDK_9.1.23.zip \
    && rm -r /opencv-${OPENCV_VERSION} \
    && rm -r /opencv_contrib-${OPENCV_VERSION} \
    && rm -r /Video_Codec_SDK_9.1.23 
