########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/datareport:v1.1
##  Start container:
##      docker stop my-test; docker rm my-test
##      docker run -t -P -d --name my-test -p 6601:5601 denny/datareport:v1.1 /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
##      docker exec -it my-test bash
##
##      docker run -t -P -d --name my-test denny/datareport:v1.1 /bin/bash
##
##  curl http://localhost:9200/_cat/indices?v
##  /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
##
##  Build Image From Dockerfile. docker build -f datareport_v1_1.dockerfile -t denny/datareport:v1.1 --rm=true .
##################################################
# https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04
FROM denny/datareport:v1.0
MAINTAINER Denny <http://dennyzhang.com>
ARG KIBANA_VERSION=4.6.1

RUN service supervisor start && sleep 5 && \
    apt-get -y update && \

# Clean up to make docker image smaller
   apt-get clean && \

# Create dummy record to elasticsearch, in order to create indice for kibana
   curl -XPUT localhost:9200/logstash-2016.08.01/logs/AVd51KVF1vucSY-abfda -d ' \
   { \
         "message": "[01/Aug/2016:00:26:02 +0000] master-index-e4010da4110ba377d100f050cb4440db ESItemNum 961", \
         "@version": "1", \
         "@timestamp": "2016-08-01T00:26:02.000Z", \
         "path": "", \
         "host": "curl_client", \
         "log_timestamp": "01/Aug/2016:00:26:02 +0000", \
         "item_name": "master-denny", \
         "property_name": "DummyTest", \
         "property_value": 0 \
    }' && \

# Configure kibana default index programmatically
    curl -XPUT http://localhost:9200/.kibana/index-pattern/logstash-* -d '{"title" : "logstash-*",  "timeFieldName": "@timestamp"}' && \
    curl -XPUT http://localhost:9200/.kibana/config/$KIBANA_VERSION -d '{"defaultIndex" : "logstash-*"}' && \

# Import kibana saved search, visualization and dashboards
   wget -O /root/kibana-mapping-exported.json \
        https://raw.githubusercontent.com/DennyZhang/devops_docker_image/tag_v2/elk/resources/kibana-mapping-exported.json && \

   elasticdump \
       --input=/root/kibana-mapping-exported.json \
       --output=http://localhost:9200/.kibana \
       --type=mapping && \

   wget -O /root/kibana-data-exported.json \
        https://raw.githubusercontent.com/DennyZhang/devops_docker_image/tag_v2/elk/resources/kibana-data-exported.json && \

   elasticdump \
       --input=/root/kibana-data-exported.json \
       --output=http://localhost:9200/.kibana \
       --type=data && \

# Stop service
   service supervisor stop && sleep 5

# Verify docker image
   # TDOO:
   # # start service and check status
   # service supervisor start || true && \
   # sleep 5 && sudo -u elasticsearch lsof -i tcp:9200 && \
   # sleep 5 && lsof -i tcp:5601 && \

EXPOSE 5601

ENV PATH /opt/logstash/bin:$PATH
ENV JAVA_HOME /opt/jdk/jre
ENV PATH $PATH:$JAVA_HOME/bin

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
########################################################################################
