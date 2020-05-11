########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/protractor:v1
##  Boot docker container: docker run -t -d --privileged -h myprotractor --name my-protractor -p 4444:4444 -p 4445:4445 -v /dev/shm:/dev/shm denny/protractor:v1 /usr/sbin/sshd -D
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

FROM denny/devubuntu:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
apt-get update
apt-get install -y libnss3-dev

# xvfb
apt-get install -y libxi6 libgconf-2-4 imagemagick xfonts-100dpi lsof
apt-get install -y xfonts-75dpi xfonts-scalable xfonts-cyrillic xvfb x11-apps

# Chrome
apt-get install -y chromium-browser

# Install node v4.4.5
# https://nodejs.org/en/download/

# Install protractor
# http://www.protractortest.org/

apt-get install -y xvfb

# python
copy protractor_rest.py templates/dirtree.html

pip install flask
mkdir -p /opt/protractor/ /opt/protractor/templates
curl  -o /opt/protractor/protractor_rest.py https://raw.githubusercontent.com/DennyZhang/devops_public/master/protractor/protractor_rest.py
curl -o /opt/protractor/templates/dirtree.html https://raw.githubusercontent.com/DennyZhang/devops_public/master/protractor/templates/dirtree.html
########################################################################################
