
FROM arm64v8/python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake ninja-build git curl wget unzip \
    libprotobuf-dev protobuf-compiler libssl-dev libpython3-dev \
    ccache gnupg2 libasan5 libtsan0
 
COPY gcc8.txt /gcc8.txt
RUN mkdir gcc8-debs && wget -i /gcc8.txt -P gcc8-debs && apt install --fix-broken ./gcc8-debs/*.deb

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100 \
    && gcc --version && g++ --version

RUN wget -qO - https://repo.download.nvidia.com/jetson/jetson-ota-public.asc | tee /etc/apt/trusted.gpg.d/jetson.asc && \
    echo "deb https://repo.download.nvidia.com/jetson/common r32.7 main" > /etc/apt/sources.list.d/jetson-common.list && \
    echo "deb https://repo.download.nvidia.com/jetson/t210 r32.7 main" > /etc/apt/sources.list.d/jetson-t210.list && \
    apt-get update && \
    apt-get install -y cuda-toolkit-10-2 libcublas10 libcublas-dev libcudnn8 libcudnn8-dev libnvinfer8 libnvinfer-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /github/workspace
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

