########## How To Use Docker Image ###############
##
##  Image Name: denny/java:v1.0
##  Build Image From Dockerfile. docker build -t denny/java:v1.0 --rm=true .
##
##  Install docker utility
##  Download docker image: docker pull denny/java:v1.0
##  Start container: docker run -t -P -d --name my-test denny/java:v1.0 /bin/bash
##################################################
FROM ubuntu:14.04
MAINTAINER Denny <http://dennyzhang.com>

ARG DEBIAN_FRONTEND=noninteractive

# https://hub.docker.com/r/podbox/java8/~/dockerfile/
RUN apt-get -y update && \
    apt-get install -y curl && \
    cd /tmp/ && \
    curl -L -k -b "oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u74-b02/server-jre-8u74-linux-x64.tar.gz | gunzip -c | tar x && \
    mv jdk1.8.0_74 /opt/jdk && \
    echo "export JAVA_HOME=/opt/jdk/jre" > /etc/profile.d/jdk.sh && \
    echo "export PATH=\"\$JAVA_HOME/bin:\$PATH\"" >> /etc/profile.d/jdk.sh && \
    chmod 644 /etc/profile.d/jdk.sh && \

# Shutdown services

# Clean up to make docker image smaller
  apt-get clean && \

# Verify docker image
  /opt/jdk/bin/java -version 2>&1 | grep "1.8"

ENV JAVA_HOME /opt/jdk/jre
ENV PATH $PATH:$JAVA_HOME/bin
CMD ["/bin/bash"]
########################################################################################
