########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/atlassian:latest
##
##  Start container:
##       docker run -t -d --privileged -h myatlassian --name my-atlassian -p 6123:22 -p 18080:8080 -p 18090:8090 -p 18000:8000 denny/atlassian:latest /usr/sbin/sshd -D
##       docker exec -it my-atlassian bash
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

FROM denny/atlassian:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
