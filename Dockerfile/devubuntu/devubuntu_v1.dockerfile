########## How To Use Docker Image ###############
##
##  Image Name: denny/devubuntu:v1
##  Install docker utility
##  Download docker image: docker pull denny/devubuntu:v1
##  Boot docker container: docker run -t -d denny/devubuntu:v1 /usr/sbin/sshd -D
##
##     ruby --version
##     gem --version
##     bundle --version
##     gem sources -l
##     python --version
##     java -version
##     chef-solo --version
##     nc -l 80
##     which pidstat
##################################################

FROM denny/sshd:v1
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
apt-get update
apt-get install -y lsof vim strace ltrace tmux curl tar telnet
apt-get install -y software-properties-common python-software-properties tree
apt-get install -y build-essential openssl git-core
apt-get install -y libcurl3 openssh-client openssh-server
apt-get install -y python-pip python-dev
apt-get install -y sysstat
# http://xmodulo.com/record-replay-terminal-session-linux.html
pip install TermRecord

# TODO: install ruby2.1
apt-get -yqq install python-software-properties && \
apt-add-repository ppa:brightbox/ruby-ng && \
apt-get -yqq update && \
apt-get -yqq install ruby2.1 ruby2.1-dev && \
rm -rf /usr/bin/ruby && \
ln -s /usr/bin/ruby2.1 /usr/bin/ruby && \
rm -rf /usr/local/bin/ruby /usr/local/bin/gem /usr/local/bin/bundle

# sete locale to UTF-8
locale-gen --lang en_US.UTF-8 && \
cat > /etc/profile.d/locale.sh <<EOF
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
EOF && \

chmod o+x /etc/profile.d/locale.sh

# install java8
add-apt-repository ppa:webupd8team/java
apt-get -y update && \
apt-get -y install oracle-java8-installer

# install docker
wget -qO- https://get.docker.com/ | sh

# stop services
service docker stop

# install chef
curl -L https://www.opscode.com/chef/install.sh | bash

# change ruby gem sources
# gem sources -a https://ruby.taobao.org/ && \
# gem sources -r https://rubygems.org/ && \
# gem sources -r http://rubygems.org/

# install nc and tcpdump
apt-get install netcat
apt-get install tcpdump

# install inotify
apt-get install inotify-tools

# http://justniffer.sourceforge.net/#!/install
sudo add-apt-repository ppa:oreste-notelli/ppa
sudo apt-get update
sudo apt-get install justniffer

# install nagios
apt-get install bc
apt-get install nagios-nrpe-server nagios-plugins nagios-nrpe-plugin
apt-get install nagios-plugins-basic libsys-statistics-linux-perl nagios3
apt-get install librrds-perl libgd-gd2-perl net-tools

apt-get install --force-yes -y sudo openssh-server curl lsb-release

# TODO: install nethogs for debugging network issue
# http://www.tecmint.com/nethogs-monitor-per-process-network-bandwidth-usage-in-real-time/
cd /tmp
wget -c https://github.com/raboof/nethogs/archive/v0.8.1.tar.gz
tar xf v0.8.1.tar.gz
cd ./nethogs-0.8.1/
# Install dependencies and build
sudo apt-get install -y libncurses5-dev libpcap-dev
make && sudo make install
# Check and run: nethogs -V

# TODO: install htop
apt-get install -y htop

apt-get update

# clean up
rm -rf /var/cache/*
rm -rf /tmp/* /var/tmp/*
rm -rf /usr/share/doc && \
apt-get autoremove && \
apt-get clean && apt-get autoclean
########################################################################################
