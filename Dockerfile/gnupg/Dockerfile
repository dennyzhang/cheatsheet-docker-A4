########## How To Use Docker Image ###############
##
##  Git link: 
##  Build docker image:
##      time docker build --no-cache -t denny/gnupg --rm=true .
##  Test image:
##      docker run -p 8083:8083 --name wordpress-test -d denny/devops-blog:code
##################################################
# Base Docker image: https://github.com/dennyzhang/challenges-aws-ecs/blob/master/Dockerfile/wordpress/Dockerfile_v2

FROM alpine:3.10
LABEL maintainer "denny.zhang001 at gmail.com"

# Install packages
RUN apk --no-cache add gnupg haveged tini

# Entrypoint
ENTRYPOINT ["/sbin/tini", "--", "gpg"]
CMD ["--version"]
