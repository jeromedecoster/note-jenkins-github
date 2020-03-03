#!/bin/bash

# the directory of this script file
dir="$(cd "$(dirname "$0")"; pwd)"
cd "$dir"

# get variables + functions
source settings.sh


# remove the container $NAME if aleady exists
if [[ -n $(docker ps --quiet --all --filter name=^${NAME}$) ]];
then
    log 'docker rm' "container $NAME"
    docker container rm --force $NAME 2>/dev/null
fi


log 'docker run' "jenkins/jenkins:lts as $NAME"
docker run \
    --detach \
    --user 0 \
    --publish 8080:$PORT \
    --publish 50000:50000 \
    --volume /var/docker/$NAME:/var/jenkins_home \
    --name $NAME \
    jenkins/jenkins:lts


ID=$(docker ps --filter name=$NAME --quiet)
var ID $ID


log 'wait' "jenkins is starting (10 seconds)"
sleep 10


# get the /var/jenkins_home/secrets/initialAdminPassword
log 'get' 'initialAdminPassword'
n=0
while true; do
    # read the password
    PASSWORD=$(docker exec $ID cat /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null)
    [[ -n "$PASSWORD" ]] && break;
    [[ $n -eq 10 ]] && err 'abort' 'initialAdminPassword not found' && exit 1;
    log 'wait' "jenkins initialAdminPassword (3 seconds)"
    sleep 3
    n=$(( n + 1 ))
done

var PASSWORD $PASSWORD

echo "open http://localhost:$HTTP/login"
