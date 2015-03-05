#!/bin/sh
alias osc="docker run --rm -i --entrypoint=osc --net=host openshift/origin:latest --insecure-skip-tls-verify"
cat application-template.json | osc process -f - | osc create -f -