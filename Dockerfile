FROM ubuntu:18.04
ARG uid
ARG gid
ARG user

RUN apt-get update && \
    apt-get install -y \
        bc \
        bison \
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
        libwxgtk3.0-dev \
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
        zip \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o jdk8.tgz https://android.googlesource.com/platform/prebuilts/jdk/jdk8/+archive/master.tar.gz && \
    tar -zxf jdk8.tgz linux-x86 && \
    mkdir -p /usr/lib/jvm && \
    mv linux-x86 /usr/lib/jvm/java-8-openjdk-amd64 && \
    rm -rf jdk8.tgz

RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x /usr/local/bin/repo

RUN useradd -m -u $uid -g $gid $user && \
    echo $user > /root/username

ENV HOME=/home/$user
ENV USER=$user
ENV USE_CCACHE=1
ENV CCACHE_EXEC=/usr/bin/ccache
ENV PATH=/home/$user/platform-tools:/usr/local/bin:/usr/lib/jvm/java-8-openjdk-amd64:$PATH
ENV ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip platform-tools-latest-linux.zip -d /home/$user && \
    rm -f platform-tools-latest-linux.zip

ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /bin/bash -i
