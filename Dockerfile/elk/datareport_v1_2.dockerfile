########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/datareport:v1.2
##  Start container:
##    docker run -t -P -d --name my-test denny/datareport:v1.2 /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
##    docker run -t -P -d --name my-test denny/datareport:v1.2 /bin/bash
##
##  curl http://localhost:9200/_cat/indices?v
##  /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
##
##  Build Image From Dockerfile. docker build -f datareport_v1_2.dockerfile -t denny/datareport:v1.2 --rm=true .
##################################################
# https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04
FROM denny/datareport:v1.1
MAINTAINER Denny <http://dennyzhang.com>

RUN service supervisor start && sleep 5 && \
    apt-get -y update && \

# Clean up to make docker image smaller
   apt-get clean && \

# Verify docker image
   # TDOO:
   # # start service and check status
   # service supervisor start || true && \
   # sleep 5 && sudo -u elasticsearch lsof -i tcp:9200 && \
   # sleep 5 && lsof -i tcp:5601 && \
   echo "Done"

EXPOSE 5601

ENV PATH /opt/logstash/bin:$PATH
ENV JAVA_HOME /opt/jdk/jre
ENV PATH $PATH:$JAVA_HOME/bin

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
########################################################################################
