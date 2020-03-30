#! /bin/bash

# Install Docker
apt-get update
apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get -y install docker-ce

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# Enable Docker Remote API
sed -i 's/^ExecStart=\/usr\/bin\/dockerd/& -H tcp:\/\/0.0.0.0:4243/' /lib/systemd/system/docker.service

# Add jenkins user to the Docker group
# usermod -aG docker jenkins

# Restart Docker service
systemctl daemon-reload
service docker restart