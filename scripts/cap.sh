#!/bin/bash
# Perform in a remote server a Capistrano command.
# First parameter correspond to the stage (i.e. staging)
# Second parameter is the task that you wnat to perform (i.e. deploy, deploy:rollback)
# Third parameter is optional and indicates Capistrano project

STAGE=$1
TASK=$2
PROJECT=$3

echo "Starting with Capistrano commands"
echo "User=> $USER"
echo "Stage=> $STAGE"
echo "Task=> $TASK"

cd /mnt/xvdf/jenkins/reso/repos/operations/capistrano/
if [ -z $PROJECT ]; then
    echo "Project=> Using default Project 'glassfish'"
    cd glassfish
else
    echo "Project=> $PROJECT"
    cd $PROJECT
fi
source /etc/profile.d/rvm.sh
echo "Current path=> $PWD"

exec cap $STAGE $TASK