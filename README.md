# openSUSE JDK8 Maven Build Image

This project creates a base build image for Maven

To run the image execute first create an alias

`alias mvn2='docker container run -it --rm --network=host -e HTTP_PROXY -e HTTPS_PROXY -e NO_PROXY -v /home/centos/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/wd -w /wd dev/apolloscm/opensuse-jdk8-maven:1.0.0-SNAPSHOT mvn'`'
