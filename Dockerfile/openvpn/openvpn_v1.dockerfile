########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/openvpn:v1
##  Boot docker container: docker run -t -p 1894:1894 -p 5022:22 -h mytest --name my-test --privileged -d denny/openvpn:v1 /usr/sbin/sshd -D
##  Start container:
##     docker exec my-openvpn service openvpn start
##
##################################################

FROM denny/sshd:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
# docker pull denny/sshd:v1
# docker run -t -p 1894:1894 -p 4022:22 --privileged --name my-test -d denny/sshd:v1 /usr/sbin/sshd -D
# ssh -p 4022 root@192.168.59.103
# https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-14-04
# apt-get update
# apt-get install -y vim
# apt-get install -y openvpn easy-rsa
# gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz > /etc/openvpn/server.conf
# vim /etc/openvpn/server.conf
##      Edit dh1024.pem to dh2048.pem
##      Uncomment push "redirect-gateway def1 bypass-dhcp"
##      Uncomment push "dhcp-option DNS 208.67.222.222" and push "dhcp-option DNS 208.67.220.220"
##      Uncomment both user nobody and group nogroup.
##      port 1194
##      proto tcp
# Package Forwarding
## echo 1 > /proc/sys/net/ipv4/ip_forward
## vim /etc/sysctl.conf
##      net.ipv4.ip_forward=1
# Iptables
##      apt-get install ufw
##      ufw allow ssh
##      port forwarding
# Configure and Build the Certificate Authority
##
##      cp -r /usr/share/easy-rsa/ /etc/openvpn
##      mkdir /etc/openvpn/easy-rsa/keys
##      vim /etc/openvpn/easy-rsa/vars
##      
##      openssl dhparam -out /etc/openvpn/dh2048.pem 2048
##      . ./vars
##      ./clean-all
##      ./build-ca
##      ./build-key-server server
##      cp /etc/openvpn/easy-rsa/keys/{server.crt,server.key,ca.crt} /etc/openvpn
##      service openvpn start
##      service openvpn status
##      cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/easy-rsa/keys/client.ovpn
##      
# Generate Certificates and Keys for Clients
##      ./build-key dennyzhang
##      
# Combine 4 files into one
##      /etc/openvpn/ca.crt
##      /etc/openvpn/easy-rsa/keys/client.ovpn
##      /etc/openvpn/easy-rsa/keys/$client.crt
##      /etc/openvpn/easy-rsa/keys/$client.key
#
## docker commit -m "initial" -a "Denny<http://dennyzhang.com>" 7572605bd8e7 denny/openvpn:v1

# clean up
rm -rf /var/cache/*
rm -rf /tmp/* /var/tmp/*
rm -rf /usr/share/doc && \
apt-get clean && apt-get autoclean
########################################################################################
