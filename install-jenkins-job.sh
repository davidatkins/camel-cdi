#!/bin/sh

alias osc="docker run --rm -i --entrypoint=osc --net=host openshift/origin:latest --insecure-skip-tls-verify"
JENKINS_ENDPOINT=`osc describe service camelcdijenkins | grep Endpoints: | awk '{print $2}'`
if [ -n "${JENKINS_ENDPOINT-}" ]; then
   cat job.xml | curl -X POST -H "Content-Type: application/xml" -H "Expect: " --data-binary @- http://$JENKINS_ENDPOINT/createItem?name=camel-cdi
else
   echo "Couldn't find the Jenkins Endpoint!"
fi