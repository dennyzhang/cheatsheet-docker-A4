########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/sshd:v1
##  Boot docker container: docker run -t -d -h mytest --name my-test --privileged -p 5022:22 denny/sshd:v1 /usr/sbin/sshd -D
##
##################################################

FROM ubuntu:14.04
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
# apt-get install -y openssh-server
# 
# sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# #  SSH login fix. Otherwise user is kicked off after login
# sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# service ssh restart
#
# sudo apt-get install vim lsof

# clean up
rm -rf /var/cache/*
rm -rf /tmp/* /var/tmp/*
rm -rf /usr/share/doc && \
apt-get clean && apt-get autoclean
########################################################################################
