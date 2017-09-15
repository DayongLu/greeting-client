FROM ubuntu
MAINTAINER dayong.lu <ludayong20@gmail.com>



RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update
RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:webupd8team/java

RUN apt-get update

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y oracle-java8-set-default
RUN apt-get clean all

RUN mkdir eureka-service
ADD ./target/greetings-client-0.0.1-SNAPSHOT.jar eureka-service
WORKDIR eureka-service
ENTRYPOINT ["sh","-c","java -Djava.security.egd=file:/dev/./urandom -jar greetings-client-0.0.1-SNAPSHOT.jar"]
