FROM debian:bullseye-slim

LABEL Name=buildbot Version=0.0.1

USER root
RUN sed -i s/deb.debian.org/mirrors.163.com/g /etc/apt/sources.list && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y cmake curl git libtool make nasm ninja-build pkg-config &&\
  apt-get install -y yasm buildbot-worker default-jre sudo unzip && \
  apt-get autoremove --purge -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i s/mirrors.163.com/deb.debian.org/g /etc/apt/sources.list

COPY install-wimal /tmp/
RUN bash /tmp/install-wimal && \
  rm /tmp/install-wimal

COPY install-gitversion /tmp/
RUN bash /tmp/install-gitversion && \
  rm /tmp/install-gitversion

RUN useradd -ms /bin/bash code && \
  echo "code ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/code && \
  chmod 0400 /etc/sudoers.d/code

USER code

COPY install-android-sdk /tmp/

RUN bash /tmp/install-android-sdk

USER root
RUN rm /tmp/install-android-sdk

RUN rm -rf /var/log/* /var/cache/*
