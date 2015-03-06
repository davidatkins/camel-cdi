# Overview

This module can be used to create a Jenkins Container and an associated build job for camel-cdi. To do this:

* First, setup an OpenShift build job that will be responsible for creating the Docker Image

      `./install-application-template.sh`

* [Install the custom Jenkins Image into OpenShift](https://github.com/atosorigin/blueprint-openshift/tree/master/blueprints/jenkins) so we can use it in a minute
* Create a Jenkins Container for this project by running

       `./install-jenkins.sh`
       
 * This will apply the 'jenkins-config.sh' to create a Pod running Jenkins, and setup a service to communicate wiht that pod named 'camelcdijenkins'
 * If you goto Hawtio 'Service' tab you should be able to connect to Jenkins
* Once Jenkins is up and running (i.e. you can access it via the webui), you can then install the camel cdi job by running
       
       `./install-jenkins-job.sh`
       
* At this point you should have a build job setup for this project. Note that it will be pointing at www.github.com/davidatkins/camel-cdi. If you want to work with your own copy, pull the repo and repoint the job to it