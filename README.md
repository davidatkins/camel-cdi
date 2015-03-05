# Overview

This is a custom Camel/CDI example for testing a deployment pipeline using Fabric8 v2, OpenShift and Jenkins

# Usage

1. Setup an OpenShift instance, see https://github.com/atosorigin/blueprint-openshift/GettingStarted.md
2. Build and push an instance of the [custom Jenkins Image](https://github.com/atosorigin/blueprint-openshift/tree/master/blueprints/jenkins) into your OpenShift instance
3. Create an instance of the Jenkins Image by running ./install-jenkins.sh
4. Once that's up and running, create a Jenkins job for this project by running ./install-jenkins-job.sh
5. Trigger a build job via the Jenkins UI (find the endpoint for the '' service)

# Dev Notes

## Docker build versus OpenShift Build

My original intention was to use 'docker build' from with-in Jenkins to do a release. This didn't work because the pod doesn't have access to the local Docker Daemon, which is required for a build. Therefore, I started working on a solution that uses STI that could then be built using the OpenShift build support.

Since then the Fabric8 guys mentioned a way to access the local docker Daemon as part of their build pipeline work. Specifically see 'exposeDockerSocker' in https://github.com/openshift/origin/blob/master/docs/builds.md#custom-builds. This would still need to be a build managed via OpenShift build mechanisms, but it means STI doesn't neccessarily have to be used.

## STI

I've used a work-in-progress Fabric8 STI image to get STI working (fabric8/java-main).

### Building Locally (Dev)

If you want to build locally (instead of using an OpenShift build), setup STI (http://www.github.com/openshift/source-to-image) and run the following:

 sti build https://github.com/davidatkins/camel-cdi.git fabric8/java-main atos/camel-cdi --loglevel=3

You can then start the container using:

    docker run -it atos/camel-cdi

## Jenkins Config

If you update the build job in jenkins, you can grab a copy of the config XML to commit using:

    wget http://$JENKINS_SERVICE:5002/job/camel-cdi/config.xml

## Manually Trigger Build

After creating the buildconfig in openshift, you can manually trigger it:

    osc build-start camel-cdi-build
    osc build-logs camel-cdi-build

# TODO

* Work out how to use a private github repo with STI (or build locally using STI)
* Create an OpenShift Build Job to create the STI build, triggered via Jenkins
