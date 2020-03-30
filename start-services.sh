#!/bin/bash

docker-compose up -d
docker container exec jenkins_server truncate -s 0 /var/jenkins_home/.ssh/known_hosts