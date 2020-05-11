########## How To Use Docker Image ###############
##
##  Install docker utility
##  Download docker image: docker pull denny/hadoop:v1
##  Boot docker container:
##     docker run -d -t -h myhadoopaio --name my-hadoop-aio --privileged -v /root/ -p 15022:22 -p 8088:8088 -p 9000:9000 -p 50000-50100:50000-50100 -p 19888:19888 denny/hadoop:v1 /usr/sbin/sshd -D
##
##  Start services:
##     docker start my-hadoop-aio
##     docker exec -it my-hadoop-aio bash
##
##     bash /usr/local/hadoop/sbin/stop-dfs.sh
##     bash /usr/local/hadoop/sbin/stop-yarn.sh
##
##     bash /usr/local/hadoop/sbin/start-dfs.sh
##     bash /usr/local/hadoop/sbin/start-yarn.sh
##
##     jps
##
##     Ports:
##        sshd 22,
##        ResourceManager: 8088, 8031, 8030, 8032, 8033
##        NameNode: 50070, localhost:9000
##        SecondaryNameNode: 50090
##        DataNode: 50010, 50075, 50020
##        NodeManager: 58095, 8040, 13562, 8042
##        
##     http endpoints:
##       NameNode: http://hadoop_ip:50070
##       ResourceManager: http://hadoop_ip:8088
##       MapReduce JobHistory Server: http://hadoop_ip:19888
##       SecondaryNameNode: http://hadoop_ip:50090
##################################################

FROM ubuntu:14.04
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################

# TODO: install packages
apt-get install -y curl tree

apt-get -y update

# clean up
rm -rf /var/cache/*
rm -rf /tmp/* /var/tmp/*
rm -rf /usr/share/doc && \
apt-get clean && apt-get autoclean
########################################################################################
