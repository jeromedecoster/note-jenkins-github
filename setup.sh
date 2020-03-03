#!/bin/bash

# the directory of this script file
dir="$(cd "$(dirname "$0")"; pwd)"
cd "$dir"

# get variables + functions
source settings.sh


log 'docker pull' 'jenkins/jenkins:lts'
docker pull jenkins/jenkins:lts
