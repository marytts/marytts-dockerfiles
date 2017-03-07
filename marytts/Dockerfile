FROM openjdk:7
RUN apt-get -y update && apt-get install -y \
  maven
RUN wget https://github.com/marytts/marytts/archive/v5.2.zip
RUN unzip v5.2.zip && \
  cd marytts-5.2 && \
  mvn install
CMD cd marytts-5.2 && target/marytts-5.2/bin/marytts-server
