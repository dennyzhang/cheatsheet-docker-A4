########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/chefserver:v1
##  Boot docker container: docker run -d -p 61080:80 -p 443:443 -p 61022:22 -h chefserver --name my-chefserver --privileged denny/chefserver:v1 /usr/sbin/sshd -D
##  Start container:
##    sysctl -w kernel.shmmax=17179869184
##    # change back hostname
##    echo "127.0.0.1 chefserver" >> /etc/hosts
##    nohup /opt/opscode/embedded/bin/runsvdir-start &
##    chef-server-ctl stop
##    chef-server-ctl start
##    chef-server-ctl status
##    chef-server-ctl tail
##    chef-server-ctl reconfigure
##    ls -lth /var/log/opscode
##    curl -k -v http://127.0.0.1:443
##
##    In client node, download admin.pem and digitalocean-validator.pem
##    create knife.rb, say ~/.chef/my-chef-knife.rb
##    knife cookbook list -c ~/.chef/my-chef-knife.rb 
##################################################

FROM denny/sshd:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
apt-get update
wget --no-check-certificate https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/*/chef-server-core_12.0.7-1_amd64.deb
dpkg -i ./chef-server-core_12.0.7-1_amd64.deb
/opt/opscode/embedded/bin/runsvdir-start &
chef-server-ctl reconfigure
chef-server-ctl status 

# clean up
rm -rf /var/cache/*
rm -rf /tmp/* /var/tmp/*
rm -rf /usr/share/doc && \
apt-get clean && apt-get autoclean
########################################################################################
