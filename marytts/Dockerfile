FROM maven:3.8.1-openjdk-8
WORKDIR /marytts
RUN wget --progress=dot:giga https://github.com/marytts/marytts/archive/refs/tags/v5.2.tar.gz \
  && tar --strip-components=1 -xzf v5.2.tar.gz \
  && rm -f v5.2.tar.gz \
  && perl -0777 -i -pe 's/(<groupId>org.fortasoft<\/groupId>\s*<artifactId>gradle-maven-plugin<\/artifactId>\s*<version>)1.0.7/${1}1.0.8/' pom.xml \
  && mvn install
EXPOSE 59125
ENTRYPOINT [ "/marytts/target/marytts-5.2/bin/marytts-server" ]
