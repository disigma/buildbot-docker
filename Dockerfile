FROM ubuntu:jammy

LABEL Name=wimal Version=0.0.1

RUN apt update && \
  apt upgrade -y && \
  apt install -y cmake curl git libtool make nasm ninja-build pkg-config vim yasm && \
  apt autoremove --purge -y && \
  apt clean -y && \
  rm -rf /var/lib/apt/lists/*

COPY install-wimal /tmp/
RUN bash /tmp/install-wimal && \
  rm /tmp/install-wimal
