FROM ubuntu
ENV BOX_VERSION=v0.2.2
ENV BEDROCK_SERVER_VERSION=1.19.81.01
RUN apt-get update && apt upgrade -y && \
    apt-get -qq install -y \
    software-properties-common \
    ca-certificates \
    curl \
    gnupg \
    wget \
    zip \
    unzip \
    cmake \
    make \
    git
RUN git clone -b ${BOX_VERSION} https://github.com/ptitSeb/box64
RUN /bin/bash -c 'cd box64;mkdir build; cd build; cmake .. -DRK3399=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo;make -j4;make install'
RUN curl -O https://minecraft.azureedge.net/bin-linux/bedrock-server-${BEDROCK_SERVER_VERSION}.zip \
    && unzip bedrock-server-${BEDROCK_SERVER_VERSION}.zip -d bedrock-server \
    && rm bedrock-server-${BEDROCK_SERVER_VERSION}.zip
WORKDIR /bedrock-server
ENV PATH=$PATH:/bedrock-server
ENTRYPOINT ["box64", "bedrock_server"]
