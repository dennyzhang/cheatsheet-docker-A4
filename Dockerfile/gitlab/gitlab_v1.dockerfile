########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/gitlab:v1
##
##  Start container:
##   docker run -t -d --privileged --name my-gitlab -h gitlab -p 40053:40053 -p 61422:22 -p 61480:80 denny/gitlab:v1 /usr/sbin/sshd -D
##
##   docker exec -it my-gitlab bash
##     sysctl -w kernel.shmmax=17179869184
##     ps -ef | grep runsvdir-start
##     nohup /opt/gitlab/embedded/bin/runsvdir-start &
##     gitlab-ctl stop
##     mv /var/opt/gitlab/gitlab-rails/sockets/gitlab.socket /tmp/
##
##     sed -i "s/external_url 'http:\/\/.*'/external_url 'http:\/\/git.test.com'/g" /etc/gitlab/gitlab.rb
##     head /etc/gitlab/gitlab.rb
##
##     gitlab-ctl start
##     gitlab-ctl status
##     # reset db, note this step is dangerous: /opt/gitlab/bin/gitlab-rake db:schema:load db:seed_fu
##     gitlab-ctl reconfigure
##     gitlab-ctl tail
##     curl http://127.0.0.1:80
##     Reset root password
##     Reset inject ssh key file
##     smtp configuration
##################################################

FROM denny/ruby2:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
# https://about.gitlab.com/downloads/#ubuntu1404
apt-get install vim lsof
apt-get install curl openssh-server ca-certificates postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
apt-get install gitlab-ce
gitlab-ctl reconfigure

# Browse in GUI: Username/Password: root/5iveL!fe (it might has been changed)

# TODO: configure smtp email sending

# clean up
rm -rf /var/cache/*
rm -rf /tmp/* /var/tmp/*
rm -rf /usr/share/doc && \
apt-get clean && apt-get autoclean
########################################################################################
