#!/bin/sh

alias osc="docker run --rm -i --entrypoint=osc --net=host openshift/origin:latest --insecure-skip-tls-verify"
JENKINS_ENDPOINT=`osc describe service atosjenkins | grep Endpoints: | awk '{print $2}'`
cat job.xml | curl -X POST -H "Content-Type: application/xml" -H "Expect: " --data-binary @- http://$JENKINS_ENDPOINT/createItem?name=camel-cdi
