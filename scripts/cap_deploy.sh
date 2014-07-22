#!/bin/bash

pwd
whoami
cd /home/deploy/Code/capistrano_SK2014/scripts/cap_deploy.sh
source /etc/profile.d/rvm.sh
exec cap $1 deploy