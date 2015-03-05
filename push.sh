#!/bin/bash
mvn clean install docker:build
docker push $DOCKER_REGISTRY/fabric8/example-camel:1.0-SNAPSHOT
# mvn fabric8:json
# some issues with fabric8:run at the moment...
cat target/classes/kubernetes.json | osc create -f -
