#!/usr/bin/env bash
##  @copyright 2018 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: container_install_devkit.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description : https://cheatsheet.dennyzhang.com/cheatsheet-docker-A4
## --
## Created : <2018-07-10>
## Updated: Time-stamp: <2018-11-23 21:39:12>
##-------------------------------------------------------------------
set -ex

function os_release() {
    # Sample: 
    # os_release -> ubuntu
    # os_release true -> ubuntu-14.04
    local show_version=${1:-"false"}
    set -e
    os_type=""
    if which lsb_release 1>/dev/null 2>/dev/null; then
        distributor_id=$(lsb_release -a 2>/dev/null | grep 'Distributor ID' | awk -F":\t" '{print $2}')
        if [ "$distributor_id" == "RedHatEnterpriseServer" ]; then
            os_type="redhat"
        fi

        if [ "$distributor_id" == "Ubuntu" ]; then
            os_type="ubuntu"
        fi
    fi

    if grep CentOS /etc/issue 1>/dev/null 2>/dev/null; then
        os_type="centos"
    fi

    if grep Debian /etc/issue 1>/dev/null 2>/dev/null; then
        os_type="debian"
    fi

    if grep Ubuntu /etc/issue 1>/dev/null 2>/dev/null; then
        os_type="ubuntu"
    fi

    if uname -a | grep '^Darwin' 1>/dev/null 2>/dev/null; then
        os_type="osx"
    fi

    if [ -z "$os_type" ]; then
        echo"ERROR: Not supported OS"
        exit 1
    fi

    if [ "$show_version" = "true" ]; then
        release_version=$(lsb_release -a 2>/dev/null | grep 'Release' | awk -F":\t" '{print $2}')
        echo "${os_type}-${release_version}"
    else
        echo "$os_type"
    fi
}

function ubuntu_install_devkit {
    echo "Install tools in ubuntu"
    apt -y update
    apt-get install -y netcat lsof
}

if [ "$os_release_name" == "ubuntu" ]; then
    ubuntu_install_devkit
fi
## File: container_install_devkit.sh ends
