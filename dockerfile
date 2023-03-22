#docker build -t opencv .
FROM ubuntu

#selection du port
EXPOSE 8080

#installation des dépendances
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y maven
RUN apt-get install -y git


RUN git clone https://github.com/barais/TPDockerSampleApp

WORKDIR ./TPDockerSampleApp

COPY ./lib .
COPY ./haarcascades .

RUN mvn install:install-file -Dfile=./lib/opencv-3410.jar -DgroupId=org.opencv  -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar
RUN mvn package

CMD java -Djava.library.path=lib/ubuntuupperthan18/ -jar target/fatjar-0.0.1-SNAPSHOT.jar
