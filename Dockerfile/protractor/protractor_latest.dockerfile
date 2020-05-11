########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/protractor:latest
##  Boot docker container: docker run -t -d --privileged -h myprotractor --name my-protractor -p 4444:4444 -p 4445:4445 -v /dev/shm:/dev/shm denny/protractor:latest /usr/sbin/sshd -D
##
##
##     Xvfb :99 -ac &
##     export DISPLAY=:99
##     ps -ef | grep 99
##
##     cd /opt/protractor/; nohup python protractor_rest.py &
##     lsof -i tcp:4445
##
##     # webdriver start takes time, which might take one minute
##     nohup webdriver-manager start &
##     webdriver-manager status
##     ps -ef | grep chrom
##     lsof -i tcp:4444
##
##     Run test:
##        cd /opt/protractor/ && protractor conf.js
##################################################

FROM denny/protractor:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################

########################################################################################
