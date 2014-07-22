#!/bin/bash

pwd
whoami
cd /mnt/xvdf/jenkins/reso/repos/operations/capistrano/glassfish/
source /etc/profile.d/rvm.sh
exec cap staging deploy