########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/datareport:v1.0
##  Start container: docker run -t -P -d --name my-test denny/datareport:v1.0 /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
##
##  /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
##
##  Build Image From Dockerfile. docker build -f datareport_v1_0.dockerfile -t denny/datareport:v1.0 --rm=true .
##################################################
# https://raw.githubusercontent.com/DennyZhang/devops_docker_image/blob/master/java/java_v1_0.dockerfile
# https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04
FROM denny/java:v1.0
MAINTAINER Denny <http://dennyzhang.com>

ARG LOGSTASH_VERSION=2.4.0
ARG ELASTICSEARCH_VERSION=2.4.1
ARG KIBANA_VERSION=4.6.1

# Install elk
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y supervisor curl wget unzip && \
    apt-get install --no-install-recommends -y lsof net-tools vim telnet && \

# install latest nodejs
   apt-get install -y build-essential && \
   cd /tmp/ && wget http://repo.fluigdata.com:18000/node-v4.5.0.tar.gz && \
   tar -xf node-v4.5.0.tar.gz && cd node-v4.5.0 && \
   # the step of make might take 20 minutes to finish
   ./configure && make && make install && \

# install elasticdump tool for backup
  npm install elasticdump -g && \

# Elasticsearch
    wget -O /opt/elasticsearch-${ELASTICSEARCH_VERSION}.zip https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/${ELASTICSEARCH_VERSION}/elasticsearch-${ELASTICSEARCH_VERSION}.zip && \
    cd /opt && \unzip elasticsearch-${ELASTICSEARCH_VERSION}.zip && \
    ln -s /opt/elasticsearch-${ELASTICSEARCH_VERSION} /opt/elasticsearch && \

    # setup elasticsearch
    useradd elasticsearch && \
    # create elasticsearch data directory
    mkdir -p /opt/elasticsearch/data /opt/elasticsearch/plugins && \
    mkdir -p /opt/elasticsearch/logs /opt/elasticsearch/config/scripts /var/run/elasticsearch && \
    chown -R elasticsearch:elasticsearch /opt/elasticsearch/data && \
    chown -R elasticsearch:elasticsearch /opt/elasticsearch/plugins /opt/elasticsearch/logs && \
    chown -R elasticsearch:elasticsearch /var/run/elasticsearch /opt/elasticsearch/config/scripts && \

    # enable elasticsearch snapshot
    mkdir -p /opt/elasticsearch/snapshot && \
    chown elasticsearch:elasticsearch /opt/elasticsearch/snapshot && \
    echo "path.repo: [\"/opt/elasticsearch/snapshot\"]" >> /opt/elasticsearch/config/elasticsearch.yml && \

# elasticsearch head plugin
    cd /opt/ && elasticsearch/bin/plugin install mobz/elasticsearch-head && \

# Kibana
   wget -O /opt/kibana-${KIBANA_VERSION}-linux-x64.tar.gz https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
   cd /opt/ && tar -xf kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
   ln -s /opt/kibana-${KIBANA_VERSION}-linux-x86_64 /opt/kibana && \

# Logstash
   wget -O /opt/logstash-${LOGSTASH_VERSION}.zip https://download.elastic.co/logstash/logstash/logstash-${LOGSTASH_VERSION}.zip && \
   cd /opt/ && unzip logstash-${LOGSTASH_VERSION}.zip && \
   ln -s /opt/logstash-${LOGSTASH_VERSION} /opt/logstash && \

# Download logstash conf file
   wget -O /opt/logstash/data_report.conf \
        https://raw.githubusercontent.com/DennyZhang/devops_docker_image/tag_v2/elk/resources/data_report.conf && \
   touch /var/log/data_report.log && \

# Start services through supervisord
   wget -O /etc/supervisor/conf.d/elasticsearch.conf \
        https://raw.githubusercontent.com/DennyZhang/devops_docker_image/tag_v2/elk/resources/elasticsearch.conf && \
   wget -O /etc/supervisor/conf.d/kibana.conf \
        https://raw.githubusercontent.com/DennyZhang/devops_docker_image/tag_v2/elk/resources/kibana.conf && \
   wget -O /etc/supervisor/conf.d/logstash.conf \
        https://raw.githubusercontent.com/DennyZhang/devops_docker_image/tag_v2/elk/resources/logstash.conf && \

# Shutdown services

# Clean up to make docker image smaller
   apt-get clean && \
   rm -rf /opt/*.zip /opt/*.tar.gz /tmp/* && \

# Verify docker image
   /opt/logstash/bin/logstash --version --version | grep ${LOGSTASH_VERSION} && \
   /opt/elasticsearch/bin/elasticsearch --version | grep ${ELASTICSEARCH_VERSION} && \
   /opt/kibana/bin/kibana --version | grep ${KIBANA_VERSION} && \
   node --version | grep "v4.5.0" && \
   npm --version | grep "2.15.9"

   # TDOO:
   # # start service and check status
   # service supervisor start || true && \
   # sleep 5 && sudo -u elasticsearch lsof -i tcp:9200 && \
   # sleep 5 && lsof -i tcp:5601 && \
   # service supervisor stop && sleep 5

EXPOSE 5601

ENV PATH /opt/logstash/bin:$PATH
ENV JAVA_HOME /opt/jdk/jre
ENV PATH $PATH:$JAVA_HOME/bin

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
########################################################################################
