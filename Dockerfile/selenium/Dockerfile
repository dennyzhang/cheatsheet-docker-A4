########## How To Use Docker Image ###############
##
##  Image Name: denny/selenium:v1
##
##  Dockerfile: selenium_v1.dockerfile
##  Docker hub link: 
##
##  Build docker image locally
##    docker build --no-cache -t denny/selenium:v1 --rm=true .
##
##  Start container:
##    mkdir -p /tmp/screenshot && chmod 777 /tmp/screenshot
##    docker run -d -p 4444:4444 -v /tmp/screenshot:/tmp/screenshot -h selenium --name selenium denny/selenium:v1
##
##  Run seleinum test
##    docker exec selenium python /home/seluser/selenium_load_page.py --page_url https://www.dennyzhang.com
##
##  Read more: https://www.dennyzhang.com/selenium_docker
##################################################

# Base image: https://hub.docker.com/r/selenium/standalone-chrome/

FROM selenium/standalone-chrome
MAINTAINER DennyZhang.com <http://dennyzhang.com>

USER root

ADD https://raw.githubusercontent.com/DennyZhang/devops_public/tag_v6/python/selenium_load_page/selenium_load_page.py \
    /home/seluser/selenium_load_page.py

# install selenium python sdk
RUN apt-get -y update && apt-get install -y --no-install-recommends curl inetutils-ping && \
    apt-get install -y --no-install-recommends python python-pip && \
    chmod 777 /home/seluser/selenium_load_page.py && \

# Download seleinum page load test scripts
    pip install selenium==3.4.0 && \

# Cleanup to make image small
    apt-get -y remove && apt-get -y autoremove && rm -rf /var/cache/apk/* && \

# Verify docker image
    which curl && which ping && \
    python --version 2>&1 | grep 2.7.12 && \
    pip --version | grep 8.1.1 && \
    pip list | grep selenium.*3.4.0

# Switch back to normal OS user
USER seluser

WORKDIR /home/seluser
