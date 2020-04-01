FROM jenkins/jenkins

USER root

# Install Docker
RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \ 
    apt-get -y install docker-ce
RUN usermod -aG docker jenkins

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# Install Maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${MAVEN_HOME}/bin:${PATH}
ADD https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz /tmp
RUN tar -zxvf tmp/apache-maven-3.6.3-bin.tar.gz -C /opt && \
     ln -s /opt/apache-maven-3.6.3 /opt/maven

USER jenkins
# Create ssh keys
RUN mkdir /usr/share/jenkins/ref/.ssh && \
    ssh-keygen -t rsa -f /usr/share/jenkins/ref/.ssh/id_rsa -N "" && \
    touch /usr/share/jenkins/ref/.ssh/known_hosts

# Install useful plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
EXPOSE 8080