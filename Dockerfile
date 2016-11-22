FROM phusion/baseimage:latest
MAINTAINER Alexandre Andrade <kaniabi@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

### TIMEZONE: Configure the docker-image timezone.
ENV TIMEZONE=America/Sao_Paulo
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime  &&\
    echo ${TIMEZONE} > /etc/timezone

### Update and root password.
RUN echo "root:chucknorris" | chpasswd


### Install packages
RUN apt-get update && apt-get install --no-install-recommends -y curl openjdk-8-jre-headless git


### JENKINS:
ENV JENKINS_VERSION=latest
ENV JENKINS_USER=jenkins
ENV JENKINS_GROUP=jenkins
ENV JENKINS_HOME=/opt/jenkins
ENV JENKINS_VOL=/var/lib/jenkins
ENV JENKINS_PLUGINS=""
# Aditional deamon: jenkins (server)
RUN mkdir /etc/service/jenkins
ADD jenkins-run.sh /etc/service/jenkins/run


EXPOSE 8080 50000
VOLUME ["${JENKINS_HOME}"]
