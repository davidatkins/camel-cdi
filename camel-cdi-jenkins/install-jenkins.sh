#!/bin/sh
alias osc="docker run --rm -i --entrypoint=osc --net=host openshift/origin:latest --insecure-skip-tls-verify"
# the awk is used to dynamically set the DOCKER_REGISTRY ip as this tends to be different per install
# TODO: could we setup an OpenShift route to remove this issue?
awk '{while(match($0,"[$]{[^}]*}")) {var=substr($0,RSTART+2,RLENGTH -3);gsub("[$]{"var"}",ENVIRON[var])}}1' jenkins-config.json | osc create -f -
