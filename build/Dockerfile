# syntax=docker/dockerfile:1.7
#== builder: box64 をビルド ==
FROM ubuntu:24.04 AS builder
ARG DEBIAN_FRONTEND=noninteractive
ARG BOX_VERSION=v0.2.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git build-essential cmake make \
    python3 pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 -b "${BOX_VERSION}" https://github.com/ptitSeb/box64 /src/box64
WORKDIR /src/box64
RUN mkdir build && cd build \
 && cmake .. -DRK3399=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo \
 && make -j"$(nproc)" \
 && make install DESTDIR=/out

#== runtime ==
FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive

ENV BEDROCK_SERVER_VERSION=1.21.102.1 \
    BEDROCK_DIR=/bedrock-server \
    PATH=$PATH:/bedrock-server

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl unzip \
 && rm -rf /var/lib/apt/lists/*

# box64 をコピー
COPY --from=builder /out/ /

WORKDIR /bedrock-server


EXPOSE 19132/udp

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
