# docker container name + volume directory name
NAME=jenkins-github
# jenkins website http port
PORT=8080


# echo $1 in underline green then $2 in yellow
log() {
   echo -e "\033[1;4;32m$1\033[0m \033[1;33m$2\033[0m"
}

# echo $1 in underline cyan then $2 without color
var() {
    echo -e "\033[1;4;36m$1\033[0m $2"
}

# echo $1 in underline magenta then $2 in cyan
err() {
    echo -e "\033[1;4;35m$1\033[0m \033[1;36m$2\033[0m" >&2
}