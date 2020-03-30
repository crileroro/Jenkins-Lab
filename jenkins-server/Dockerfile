FROM jenkins/jenkins

USER root

ENV MAVEN_HOME=/opt/maven

ENV PATH=${MAVEN_HOME}/bin:${PATH}

ADD https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz /tmp

RUN tar -zxvf tmp/apache-maven-3.6.3-bin.tar.gz -C /opt

RUN ln -s /opt/apache-maven-3.6.3 /opt/maven

USER jenkins

RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""

EXPOSE 8080