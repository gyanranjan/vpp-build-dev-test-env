FROM ubuntu:bionic
MAINTAINER granjan@docker.com


#Setup Build Environment
RUN  apt-get update -qq && \
     apt-get install -qqy build-essential \
     vim tmux iproute2 iputils-ping net-tools \
     vim-tiny jshon telnet curl wget ethtool  \
     libnuma1 libssl1.0.0 libmbedcrypto1 libmbedtls10 libmbedx509-0 \
     apt-transport-https \
     ca-certificates \
     curl \
     lxc \
     iptables 


# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh


#https://hub.docker.com/r/goyalzz/ubuntu-java-8-maven-docker-image/dockerfile
# Prepare installation of Oracle Java 8
ENV JAVA_VER 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH "$JAVA_HOME/bin:$PATH"

# Install git, wget, Oracle Java8
RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    apt-get update && \
    apt-get install -y git wget && \
    echo oracle-java${JAVA_VER}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y --force-yes --no-install-recommends oracle-java${JAVA_VER}-installer oracle-java${JAVA_VER}-set-default && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /var/cache/oracle-jdk${JAVA_VER}-installer

# Set Oracle Java as the default Java
RUN update-java-alternatives -s java-8-oracle
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc

# Install maven 3.3.9
RUN wget --no-verbose -O /tmp/apache-maven-3.3.9-bin.tar.gz http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
    tar xzf /tmp/apache-maven-3.3.9-bin.tar.gz -C /opt/ && \
    ln -s /opt/apache-maven-3.3.9 /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/local/bin  && \
    rm -f /tmp/apache-maven-3.3.9-bin.tar.gz

ENV MAVEN_HOME /opt/maven

RUN  apt-get update -qq && \
     apt-get install -qqy  gdb sudo autoconf automake \
            autopoint autotools-dev \
            bsdmainutils ca-certificates-java ccache \
            check chrpath clang-format clang-format-6.0 \
            cmake cmake-data cscope debhelper \
            default-jdk-headless default-jre-headless \
            dh-autoreconf dh-python dh-strip-nondeterminism \
            dh-systemd  distro-info-data dkms exuberant-ctags \
            fontconfig-config fonts-dejavu-core gettext \
            gettext-base gir1.2-glib-2.0 gir1.2-harfbuzz-0.0 \
            git-review groff-base ibverbs-providers icu-devtools \
            indent intltool-debian kmod lcov libapr1 \
            libapr1-dev libarchive-cpio-perl \
            libarchive-zip-perl libarchive13 \
            libavahi-client3 libavahi-common-data \
            libavahi-common3 libboost-all-dev \
            libboost-atomic-dev libboost-atomic1.65-dev \
            libboost-atomic1.65.1 libboost-chrono-dev \
            libboost-chrono1.65-dev libboost-chrono1.65.1 \
            libboost-container-dev \
            libboost-container1.65-dev \
            libboost-container1.65.1 libboost-context-dev \
            libboost-context1.65-dev libboost-context1.65.1 \
            libboost-coroutine-dev libboost-coroutine1.65-dev \
            libboost-coroutine1.65.1 libboost-date-time-dev libboost-date-time1.65-dev \
            libboost-date-time1.65.1 libboost-dev libboost-exception-dev \
libboost-exception1.65-dev libboost-fiber-dev libboost-fiber1.65-dev libboost-fiber1.65.1 libboost-filesystem-dev \
libboost-filesystem1.65-dev libboost-filesystem1.65.1 libboost-graph-dev \
libboost-graph-parallel-dev libboost-graph-parallel1.65-dev \
libboost-graph-parallel1.65.1 libboost-graph1.65-dev libboost-graph1.65.1 \
libboost-iostreams-dev libboost-iostreams1.65-dev libboost-iostreams1.65.1 \
libboost-locale-dev libboost-locale1.65-dev \
libboost-locale1.65.1 libboost-log-dev libboost-log1.65-dev libboost-log1.65.1 libboost-math-dev libboost-math1.65-dev libboost-math1.65.1 libboost-mpi-dev libboost-mpi-python-dev libboost-mpi-python1.65-dev libboost-mpi-python1.65.1 libboost-mpi1.65-dev \
libboost-mpi1.65.1 libboost-numpy-dev libboost-numpy1.65-dev libboost-numpy1.65.1 libboost-program-options-dev libboost-program-options1.65-dev libboost-program-options1.65.1 libboost-python-dev libboost-python1.65-dev libboost-python1.65.1 libboost-random-dev \
libboost-random1.65-dev libboost-random1.65.1 libboost-regex-dev libboost-regex1.65-dev libboost-regex1.65.1 libboost-serialization-dev libboost-serialization1.65-dev libboost-serialization1.65.1 libboost-signals-dev libboost-signals1.65-dev libboost-signals1.65.1 \
libboost-stacktrace-dev libboost-stacktrace1.65-dev libboost-stacktrace1.65.1 libboost-system-dev libboost-system1.65-dev libboost-system1.65.1 libboost-test-dev libboost-test1.65-dev libboost-test1.65.1 libboost-thread-dev libboost-thread1.65-dev \
libboost-thread1.65.1 libboost-timer-dev libboost-timer1.65-dev libboost-timer1.65.1 libboost-tools-dev libboost-type-erasure-dev libboost-type-erasure1.65-dev libboost-type-erasure1.65.1 libboost-wave-dev libboost-wave1.65-dev libboost-wave1.65.1 libboost1.65-dev \
libboost1.65-tools-dev libconfuse-common libconfuse-dev libconfuse-doc libconfuse2 libcroco3 libcups2 libexpat1-dev libfabric1 libffi-dev libfile-stripnondeterminism-perl libfontconfig1 libfreetype6 libgd-perl libgd3 libgirepository-1.0-1 libglib2.0-0 libglib2.0-bin \
libglib2.0-data libglib2.0-dev libglib2.0-dev-bin libgraphite2-3 libgraphite2-dev libharfbuzz-dev libharfbuzz-gobject0 libharfbuzz-icu0 libharfbuzz0b libhwloc-dev libhwloc-plugins libhwloc5 libibverbs-dev libibverbs1 libicu-dev libicu-le-hb-dev libicu-le-hb0 libicu60 \
libiculx60 libjbig0 libjpeg-turbo8 libjpeg8 libjsoncpp1 libkmod2 liblcms2-2 libllvm6.0 libltdl-dev liblzo2-2 libmail-sendmail-perl libmbedtls-dev libnl-3-200 libnl-route-3-200 libnspr4 libnss3 libnuma-dev libopenmpi-dev libopenmpi2 libpciaccess0 libpcre16-3 \
libpcre3-dev libpcre32-3 libpcrecpp0v5 libpcsclite1 libpipeline1 libpng16-16 libpsm-infinipath1 libpython-all-dev libpython-dev libpython-stdlib libpython2.7 libpython2.7-dev libpython2.7-minimal libpython2.7-stdlib libpython3-dev libpython3-stdlib libpython3.6-dev \
librdmacm1 librhash0 libsctp-dev libsctp1 libsigsegv2 libssl-dev libssl-doc libsubunit-dev libsubunit0 libsys-hostname-long-perl libtiff5 libtimedate-perl libtool libuv1 libwebp6 libxi6 libxml2 libxpm4 libxrender1 libxtst6 linux-headers-4.15.0-45 \
linux-headers-4.15.0-45-generic linux-headers-generic lsb-release m4 man-db mpi-default-bin mpi-default-dev ninja-build ocl-icd-libopencl1 openjdk-11-jdk-headless openjdk-11-jre-headless openmpi-bin openmpi-common pkg-config po-debconf python python-all \
python-all-dev python-asn1crypto python-cffi-backend python-crypto python-cryptography python-dbus python-dev python-enum34 python-gi python-idna python-ipaddress python-keyring python-keyrings.alt python-minimal python-pip python-pip-whl python-pkg-resources \
python-secretstorage python-setuptools python-six python-virtualenv python-wheel python-xdg python2.7 python2.7-dev python2.7-minimal python3 python3-certifi python3-chardet python3-dev python3-distutils python3-idna python3-lib2to3 python3-minimal \
python3-pkg-resources python3-ply python3-requests python3-six python3-urllib3 python3-virtualenv python3.6 python3.6-dev python3.6-minimal shared-mime-info ucf uuid-dev virtualenv x11-common xdg-user-dirs zlib1g-dev 

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu -p "$(openssl passwd -1 ubuntu)"
USER ubuntu
WORKDIR /home/ubuntu

RUN mkdir -p  ~/.m2
RUN touch  ~/.m2/settings.xml 

EXPOSE 80 443



