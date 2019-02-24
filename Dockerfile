FROM ubuntu:bionic
MAINTAINER granjan@docker.com

#Setup Build Environment
#RUN  rm -rf /var/lib/apt/lists/*

RUN  apt-get update -qq && \
     apt-get install -qqy build-essential \
     vim tmux iproute2 iputils-ping net-tools \
     vim-tiny jshon telnet curl wget ethtool  \
     libnuma1 libssl1.0.0 libmbedcrypto1 libmbedtls10 libmbedx509-0 \
     apt-transport-https \
     ca-certificates \
     curl \
     iptables \
     python-cffi python-ply \
     python-pycparser libpam-cgfs \
     gdb python3 sudo git wget

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
    echo oracle-java${JAVA_VER}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y --force-yes --no-install-recommends oracle-java${JAVA_VER}-installer oracle-java${JAVA_VER}-set-default && \
    apt-get clean && \
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

#RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu -p "$(openssl passwd -1 ubuntu)"

RUN  rm -rf /var/lib/apt/lists/* `# clear apt cache` 
RUN  rm -rf packages

RUN mkdir -p  ~/.m2 
RUN  touch  ~/.m2/settings.xml 


#USER ubuntu
#WORKDIR /home/ubuntu
# Reduce image size


EXPOSE 80 443

