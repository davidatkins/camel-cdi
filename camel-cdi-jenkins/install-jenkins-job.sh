#!/bin/sh

alias osc="docker run --rm -i --entrypoint=osc --net=host openshift/origin:latest --insecure-skip-tls-verify"
JENKINS_ENDPOINT=`osc describe service camelcdijenkins | grep Endpoints: | awk '{print $2}'`
# TODO: should be able to use the OpenShift proxy to talk to jenkins rather than having to find the service IP. See Fabric8 IRC chat logs from around 4pm 5/3/15
if [ -n "${JENKINS_ENDPOINT-}" ]; then
   cat job.xml | curl -X POST -H "Content-Type: application/xml" -H "Expect: " --data-binary @- http://$JENKINS_ENDPOINT/createItem?name=camel-cdi
else
   echo "Couldn't find the Jenkins Endpoint!"
fi