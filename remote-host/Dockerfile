FROM centos

RUN yum update -y && \
    yum install openssh-server -y

RUN useradd remote_user && \
    echo "remote_user:remote_user" | chpasswd && \
    mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY --from=crileroro/jenkins-docker:latest /usr/share/jenkins/ref/.ssh/id_rsa.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user -R /home/remote_user/.ssh && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN ssh-keygen -A

RUN rm /run/nologin

CMD /usr/sbin/sshd -D