#!/usr/bin/env bash
##  @copyright 2018 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: delete_all_containers.sh
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2018-07-10>
## Updated: Time-stamp: <2018-07-10 13:35:27>
##-------------------------------------------------------------------
set -e
echo "Before deleting containers"
docker ps -a
docker ps -aq | xargs docker stop
docker ps -aq | xargs docker rm

echo "After deleting containers"
docker ps -a
## File: delete_all_containers.sh ends
