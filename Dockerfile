FROM anapsix/alpine-java:7
MAINTAINER Alexandre Andrade <kaniabi@gmail.com>


# Setup environment
ENV JENKINS_VERSION latest
ENV JENKINS_USER jenkins
ENV JENKINS_GROUP jenkins
ENV JENKINS_HOME /opt/jenkins
ENV JENKINS_VOL /var/lib/jenkins
ENV TIMEZONE America/Sao_Paulo

# Install software
RUN apk update \
    && apk upgrade \
    && apk add --no-cache tzdata curl \
    && mkdir -p $JENKINS_HOME $JENKINS_VOL/plugins $JAVA_BASE \
    && addgroup ${JENKINS_GROUP} \
    && adduser -h ${JENKINS_HOME} -D -s /bin/bash -G ${JENKINS_GROUP} ${JENKINS_USER} \
    && chown -R ${JENKINS_USER}:${JENKINS_GROUP} ${JENKINS_HOME} ${JENKINS_VOL} \
    && for plugin in credentials ssh-credentials ssh-agent ssh-slaves git-client git github github-api github-oauth github-pullrequest ghprb scm-api simple-theme-plugin shiningpanda slack swarm ; do  curl -sSL http://updates.jenkins-ci.org/latest/${plugin}.hpi --output $JENKINS_VOL/${plugin}.hpi; done \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo ${TIMEZONE} > /etc/timezone \
    && apk del tzdata

# Listen for main web interface (8080/tcp) and attached slave agents (50000/tcp)
EXPOSE 8080 50000

# Expose volumes
VOLUME ["${JENKINS_VOL}"]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

USER ${JENKINS_USER}

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD [""]
