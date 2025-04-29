
FROM arm64v8/python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

COPY entrypoint.sh /entrypoint.sh
COPY gcc-8.pref /etc/apt/preferences.d/gcc-8

RUN chmod +x /entrypoint.sh && echo "deb http://deb.debian.org/debian buster main" >> /etc/apt/sources.list.d/buster.list && \
apt-get update && apt-get install -y --no-install-recommends make cmake ninja-build git curl wget unzip \
    libprotobuf-dev protobuf-compiler libssl-dev libpython3-dev apt-transport-https ccache gnupg ca-certificates \
    lsb-release software-properties-common gcc-8 g++-8 libgcc-8-dev libstdc++-8-dev && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 100 \
    && gcc --version && g++ --version && rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://repo.download.nvidia.com/jetson/jetson-ota-public.asc | tee /etc/apt/trusted.gpg.d/jetson.asc && \
    echo "deb https://repo.download.nvidia.com/jetson/common r32.7 main" > /etc/apt/sources.list.d/jetson-common.list && \
    echo "deb https://repo.download.nvidia.com/jetson/t210 r32.7 main" > /etc/apt/sources.list.d/jetson-t210.list && \
    apt-get update && \
    apt-get install -y cuda-toolkit-10-2 libcublas10 libcublas-dev libcudnn8 libcudnn8-dev libnvinfer8 libnvinfer-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]
