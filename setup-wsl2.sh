#!/bin/bash
set -e

# NOTE: libwxgtk3.0-dev is unavailable on WSL2!
sudo apt update && \
    sudo apt full-upgrade -y && \
    sudo apt install -y \
         bc \
         bison \
         brotli \
         build-essential \
         ccache \
         curl \
         flex \
         fontconfig \
         gcc-multilib \
         g++-multilib \
         git \
         git-core \
         gnupg \
         gperf \
         imagemagick \
         libc6-dev-i386 \
         libgl1-mesa-dev \
         liblz4-tool \
         libncurses5 \
         libncurses5-dev \
         libsdl1.2-dev \
         libssl-dev \
         libxml2 \
         libxml2-utils \
         libx11-dev \
         lib32ncurses5-dev \
         lib32readline-dev \
         lib32z1-dev \
         lzop \
         m4 \
         pngcrush \
         python \
         python-markdown \
         rsync \
         schedtool \
         squashfs-tools \
         xsltproc \
         unzip \
         wget \
         xsltproc \
         x11proto-core-dev \
         unzip \
         zip \
         zlib1g-dev

curl -o jdk8.tgz https://android.googlesource.com/platform/prebuilts/jdk/jdk8/+archive/master.tar.gz && \
    tar -zxf jdk8.tgz linux-x86 && \
    sudo mkdir -p /usr/lib/jvm && \
    sudo mv linux-x86 /usr/lib/jvm/java-8-openjdk-amd64 && \
    rm -rf jdk8.tgz

curl -o repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x repo && \
    sudo mv repo /usr/local/bin

sudo git clone https://github.com/xpirt/sdat2img /usr/local/sdat2img

wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip platform-tools-latest-linux.zip -d $HOME && \
    rm -f platform-tools-latest-linux.zip
