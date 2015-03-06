# Overview

This module can be used to create a Jenkins Container and an associated build job for camel-cdi. To do this:

* Create a Jenkins Container by running

       `./install-jenkins.sh`
       
 * This will apply the 'jenkins-config.sh' to create a Pod running Jenkins, and setup a service to communicate wiht that pod named 'camelcdijenkins'
* Once Jenkins is up and running (i.e. you can access it via the webui), you can then install the camel cdi job by running
       
       `./install-jenkins-job.sh`
       
* At this point you should have a build job setup for this project. Note that it will be pointing at www.github.com/davidatkins/camel-cdi. If you want to work with your own copy, pull the repo and repoint the job to it