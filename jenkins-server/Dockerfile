FROM jenkins/jenkins

USER root

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