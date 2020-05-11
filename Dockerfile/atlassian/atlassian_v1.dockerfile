########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/atlassian:v1
##
##  Start container:
##       docker run -t -d --privileged -h myatlassian --name my-atlassian -p 6123:22 -p 18080:8080 -p 18090:8090 -p 18000:8000 denny/atlassian:v1 /usr/sbin/sshd -D
##       docker exec -it my-atlassian bash
##       service mysql start
##       cd /opt/atlassian/jira/bin; ./shutdown.sh
##       cd /opt/atlassian/jira/bin; ./startup.sh
##       tail -f /opt/atlassian/jira/logs/catalina.out
##       lsof -i tcp:8080
##       JIRA: curl -v http://127.0.0.1:8080/
##
##       cd /opt/atlassian/confluence/bin; ./shutdown.sh
##       cd /opt/atlassian/confluence/bin; ./startup.sh
##       tail -f /opt/atlassian/confluence/logs/catalina.out
##       lsof -i tcp:8090
##       Confluence: curl -v http://127.0.0.1:8090/
##
##       Confluence: PDF Export Language Support -> Support Chinese
##
##       Reconfigure url
##         JIRA: System --> Settings --> Application title, Base URL
##         Confluence: General Configuration --> Site Title, Server Base URL
##
##       Reconfigure application url
##         Confluence: Confluence Configuration -> Application Links
##                     Create application, configure outgoing authentication -> Basic Access
##         Confluence: Confluence Configuration -> Application Navigator
##         JIRA: System -> Application Navigator
##
##       Reconfigure webhook for JIRA and Confluence: BearyChat
##         JIRA: System -> WebHooks
##         Confluence: Confluence Configuration -> Manage add-ons
##
##       Reconfigure smtp email for JIRA and Confluence
##
##       Remove existing users and projects
##       Reset password
##
##         service mysql start
##         service mysql status
##
##         cd /opt/atlassian/jira/bin; ./shutdown.sh
##         cd /opt/atlassian/jira/bin; ./startup.sh
##         tail -f /opt/atlassian/jira/logs/catalina.out
##
##         cd /opt/atlassian/confluence/bin; ./shutdown.sh
##         cd /opt/atlassian/confluence/bin; ./startup.sh
##         tail -f /opt/atlassian/confluence/logs/catalina.out
##
##         JIRA: curl -v http://127.0.0.1:8080/
##         Confluence: curl -v http://127.0.0.1:8090/
##
##         Reconfigure url
##           JIRA: System --> Settings --> Application title, Base URL
##           Confluence: General Configuration --> Site Title, Server Base URL
##
##         Reconfigure application url
##           Confluence: Application Links
##           JIRA: Application Navigator
##
##         jira daily backup: /var/atlassian/application-data/jira/export
##         confluence daily backup: /var/atlassian/application-data/confluence/backups
##         Reconfigure smtp email for JIRA and Confluence
##
##         Remove existing users and projects
##         Reset password
##
##################################################

FROM denny/java:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

# http://linoxide.com/linux-how-to/setup-jira-ubuntu-15-04/
# http://blog.163.com/s_w_wang/blog/static/1716092212014726101210574/

########################################################################################
RUN apt-get install -y zip unzip

# Install mysql
RUN apt-get install -y mysql-server mysql-client libmysqlclient-dev libmysql-java

# Download atlassian jira binary
RUN wget https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.0.3-jira-7.0.3-x64.bin && \
    chmod +x atlassian-jira-software-7.0.3-jira-7.0.3-x64.bin && \
   ./atlassian-jira-software-7.0.3-jira-7.0.3-x64.bin && \
   rm -rf ./atlassian-jira-software-7.0.3-jira-7.0.3-x64.bin

####################################
# JIRA
# Start and initialize mysql
#    service mysql start
#    service mysql status
#    mysql -u root -p
#        create database jira character set UTF8;
#        create user jira identified by "123456";
#        grant all on jira.* to "jira"@"%" identified by "123456" with grant option;
#        grant all on jira.* to "jira"@"localhost" identified by "123456" with grant option;
#        FLUSH PRIVILEGES;
#        quit

####################################
# JIRA
mkdir -p /root/jira_original/
cp /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/atlassian-extras-2.2.2.jar /root/jira_original/
cp /opt/atlassian/jira/atlassian-jira/WEB-INF/atlassian-bundled-plugins/atlassian-universal-plugin-manager-plugin-2.19.1.jar /root/jira_original/

####################################
# Install and start JIRA
cp /usr/share/java/mysql-connector-java-5.1.28.jar /opt/atlassian/jira/lib/
cd /opt/atlassian/jira/bin
./shutdown.sh
./startup.sh

####################################
# Initialize in web browser
# http://$server_ip:8080

####################################
# Confluence
RUN wget https://downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-5.6.5-x64.bin && \
    chmod +x atlassian-confluence-5.6.5-x64.bin && \
   ./atlassian-confluence-5.6.5-x64.bin && \
   rm -rf ./atlassian-confluence-5.6.5-x64.bin

cp /usr/share/java/mysql-connector-java-5.1.28.jar /opt/atlassian/confluence/lib/

# Start and initialize mysql
#    service mysql start
#    service mysql status
#    mysql -u root -p
#        create database confluence character set UTF8;
#        create user confluence identified by "123456";
#        grant all on confluence.* to "confluence"@"%" identified by "123456" with grant option;
#        grant all on confluence.* to "confluence"@"localhost" identified by "123456" with grant option;
#        FLUSH PRIVILEGES;
#        quit

cd /opt/atlassian/confluence/confluence/WEB-INF/lib

# clean up
rm -rf /var/cache/*
rm -rf /tmp/* /var/tmp/*
rm -rf /usr/share/doc
########################################################################################
