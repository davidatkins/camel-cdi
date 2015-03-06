#!/bin/sh

alias osc="docker run --rm -i --entrypoint=osc --net=host openshift/origin:latest --insecure-skip-tls-verify"
JENKINS_ENDPOINT=`osc describe service camelcdijenkins | grep Endpoints: | awk '{print $2}'`
# Below should work, but i had issues. Not too bothered because jenkins jobs will be configured via git pull at somepoint instead...
#JENKINS_ENDPOINT="http://172.30.17.180/kubernetes/api/v1beta2/proxy/services/camelcdijenkins/"
if [ -n "${JENKINS_ENDPOINT-}" ]; then
   JENKINS_ENDPOINT="http://$JENKINS_ENDPOINT"
   echo $JENKINS_ENDPOINT
   cat job.xml | curl -L -X POST -H "Content-Type: application/xml" -H "Expect: " --data-binary @- $JENKINS_ENDPOINT/createItem?name=camel-cdi
else
   echo "Couldn't find the Jenkins Endpoint!"
fi