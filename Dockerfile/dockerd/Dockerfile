########## How To Use Docker Image ###############
##
##  Image Name: denny/docker:v1.0
##  Install docker utility
##  Download docker image: docker pull denny/docker:v1.0
##
##  Build Image From Dockerfile. docker build denny/docker:v1.0 --rm=true .
##################################################
FROM ubuntu:14.04
MAINTAINER DennyZhang.com <https://www.dennyzhang.com/contact>

ARG DEBIAN_FRONTEND=noninteractive
ARG docker_version="1.12.1"

RUN apt-get -y update && \
  apt-get install -y curl wget vim && \

# Install basic packages
  apt-get install -y python build-essential && \

# Install docker daemon
  wget -qO- https://get.docker.com/ | sh &&  \
  apt-get install -y --force-yes docker-engine=1.12.1-0~trusty &&  \
  apt-mark hold docker-engine && \

# Shutdown services
  (service docker start || true) && \

# pull basic golden images to speed up the test
  # TODO: skip this temporarily
  # sleep 5 && docker pull ubuntu:14.04 && \

# Clean up to make docker image smaller
  apt-get clean && \

# Verify docker image
  # TODO: skip this temporarily
  # docker images | grep ubuntu.*14.04 && \
  (service docker stop || true) && \
  docker --version | grep "$docker_version"

CMD ["/usr/bin/dockerd"]
########################################################################################
