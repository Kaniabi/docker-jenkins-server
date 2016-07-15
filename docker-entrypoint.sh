#! /bin/bash

set -eo pipefail

# If there are any arguments then we want to run those instead
if [[ "$1" == "-"* || -z $1 ]]; then
  # On each execution updates JENKINS
  curl -sSL http://mirrors.jenkins-ci.org/war/${JENKINS_VERSION}/jenkins.war --output ${JENKINS_HOME}/jenkins.war
  chown ${JENKINS_USER}:${JENKINS_GROUP} ${JENKINS_HOME}/jenkins.war

  if [ -z "$JENKINS_PLUGINS" ]; then
      for plugin in ${JENKINS_PLUGINS}; do
        echo curl -sSL http://updates.jenkins-ci.org/latest/${plugin}.hpi --output $JENKINS_VOL/${plugin}.hpi
      done
  fi

  exec java $JAVA_OPTS -jar /opt/jenkins/jenkins.war "$@"
else
  exec "$@"
fi
