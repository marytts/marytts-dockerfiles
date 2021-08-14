FROM maven:3.8.1-openjdk-8
RUN wget https://github.com/marytts/marytts/archive/v5.2.zip && \
  unzip v5.2.zip && \
  rm -f v5.2.zip && \
  mv marytts-5.2 marytts
RUN cd marytts && \
  perl -0777 -i -pe 's/(<groupId>org.fortasoft<\/groupId>\s*<artifactId>gradle-maven-plugin<\/artifactId>\s*<version>)1.0.7/${1}1.0.8/' pom.xml && \
  mvn install
CMD /marytts/target/marytts-5.2/bin/marytts-server
EXPOSE 59125
