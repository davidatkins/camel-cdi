# Overview

This is a custom Camel/CDI example for testing a deployment pipeline using Fabric8 v2, OpenShift and Jenkins

# Usage

1. Build the project

      `mvn install`

2. Setup an OpenShift instance, see [atos blueprint wiki](https://github.com/atosorigin/blueprint-openshift/GettingStarted.md)
3. [Create a Jenkins Instance and Job](camel-cdi-ci/README.md)
4. Trigger a build job via the Jenkins UI (find the endpoint for the '' service)

This job will:

* Checkout the code
* Build the maven project, running any unit tests
* Trigger an openshift build (defined in the application-template)
 * This will use STI to build the image, and insert it into the OpenShift Registry
* Once complete, run the Fabric8 Integration Tests. This will deploy the previously built image to a temporary namespace and run integration tests

# Dev Notes

## Docker build versus OpenShift Build

My original intention was to use 'docker build' from with-in Jenkins to do a release. This didn't work because the pod doesn't have access to the local Docker Daemon, which is required for a build. Therefore, I started working on a solution that uses STI that could then be built using the OpenShift build support.

Since then the Fabric8 guys mentioned a way to access the local docker Daemon as part of their build pipeline work. Specifically see 'exposeDockerSocker' in https://github.com/openshift/origin/blob/master/docs/builds.md#custom-builds. This would still need to be a build managed via OpenShift build mechanisms, but it means STI doesn't neccessarily have to be used.

## STI

I've used a work-in-progress Fabric8 STI image to get STI working (fabric8/java-main). See [STI page on the Atos blueprint wiki](https://github.com/atosorigin/blueprint-openshift/STI.md) for general information about this.

### Building Locally (Dev)

If you want to build locally (instead of using an OpenShift build), setup STI (http://www.github.com/openshift/source-to-image) and run the following:

    build-sti.sh

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
