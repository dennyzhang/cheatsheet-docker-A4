########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/chefserver:latest
##  Boot docker container: docker run -d -p 61080:80 -p 443:443 -p 61022:22 -h chefserver --name my-chefserver --privileged denny/chefserver:latest /usr/sbin/sshd -D
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

FROM denny/chefserver:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################

########################################################################################
