########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/gitlab:latest
##
##  Start container:
##   docker run -t -d --privileged --name gitlab -h my-gitlab -p 61422:22 -p 61480:80 denny/gitlab:latest /usr/sbin/sshd -D
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
##     curl http://127.0.0.1:80
##     gitlab-ctl reconfigure
##     gitlab-ctl tail
##     curl http://127.0.0.1:80
##################################################

FROM denny/gitlab:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################

########################################################################################
