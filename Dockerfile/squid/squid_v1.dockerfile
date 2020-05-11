########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/squid:v1
##  Boot docker container: docker run -t -P -d denny/squid:v1 /usr/sbin/sshd -D
##
##################################################

FROM ubuntu:14.04
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
# TODO: to be implemented
# clean up
rm -rf /var/cache/*
rm -rf /tmp/* /var/tmp/*
rm -rf /usr/share/doc && \
apt-get clean && apt-get autoclean
########################################################################################
