FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y install openjdk-8-jdk && \
    apt-get -y install openssh-server && \
    mkdir -p /var/run/sshd 
RUN adduser --quiet jenkins && \
    echo "jenkins:jenkins" | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
