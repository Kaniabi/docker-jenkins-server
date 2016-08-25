#!/bin/bash

curl -sSL http://mirrors.jenkins-ci.org/war/${JENKINS_VERSION}/jenkins.war --output ${JENKINS_HOME}/jenkins.war
chown ${JENKINS_USER}:${JENKINS_GROUP} ${JENKINS_HOME}/jenkins.war

#if [ -z "$JENKINS_PLUGINS" ]; then
#  for i_plugin in ${JENKINS_PLUGINS}; do
#    echo curl -sSL http://updates.jenkins-ci.org/latest/${i_plugin}.hpi --output $JENKINS_VOL/${i_plugin}.hpi
#  done
#fi

exec java $JAVA_OPTS -jar ${JENKINS_HOME}/jenkins.war "$@"
