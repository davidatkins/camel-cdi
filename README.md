STI Build

    sti build https://github.com/davidatkins/camel-cdi.git fabric8/java-main atos/camel-cdi --loglevel=3

Then run

    docker run -it -e "JAVA_MAIN=org.apache.camel.cdi.Main" atos/camel-cdi

TODO: set JAVA_MAIN in default image

To save job from jenkins into job.xml, can do via REST API:

wget http://172.30.17.169:5002/job/camel-cdi/config.xml