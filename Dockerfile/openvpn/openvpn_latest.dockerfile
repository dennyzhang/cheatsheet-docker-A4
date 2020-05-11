########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/openvpn:latest
##  Boot docker container: docker run -t -p 1894:1894 -p 5022:22 -h mytest --name my-test --privileged -d denny/openvpn:latest /usr/sbin/sshd -D
##  Start container:
##     docker exec my-openvpn service openvpn start
##
##################################################

FROM denny/openvpn:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################

########################################################################################
