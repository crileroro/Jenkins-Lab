#!/bin/bash

# Creation of the mount point to be used by the Jenkins service 
mkdir jenkins-server/jenkins-home
chown -R 1000:1000 jenkins-server/jenkins-home

docker-compose up -d

# Deletion of the known host when deleting and building again the remote_host service
docker container exec jenkins_server truncate -s 0 /var/jenkins_home/.ssh/known_hosts