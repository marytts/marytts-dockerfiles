FROM openjdk:8-slim AS builder

WORKDIR /work/marytts
ADD https://github.com/marytts/marytts/archive/master.tar.gz marytts.tar.gz

RUN tar -xzf marytts.tar.gz --strip-components 1
RUN ./gradlew installDist --parallel

WORKDIR /work/marytts/build/install/marytts
COPY voice-serbski-institut-dsb-juro-0.1.0-SNAPSHOT-legacy.zip \
    voice-serbski-institut-hsb-matej-0.1.0-SNAPSHOT-legacy.zip download/
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -qq install \
      unzip \
    && find download/ -name voice-serbski-institut-\*.zip \
      -exec unzip {} \; \
      -delete

FROM alpine

RUN apk add --no-cache \
    curl \
    openjdk8

WORKDIR /marytts
COPY --from=builder /work/marytts/build/install/marytts .

EXPOSE 59125/tcp
ENV JAVA_OPTS="-Dlog4j.logger.marytts=INFO,stderr -Dsocket.addr=0.0.0.0"
ENTRYPOINT /marytts/bin/marytts-server

ADD https://repo1.maven.org/maven2/de/dfki/mary/marytts-lexicon-dsb/0.1.0/marytts-lexicon-dsb-0.1.0.jar lib/
ADD https://repo1.maven.org/maven2/de/dfki/mary/marytts-lang-dsb/0.1.0/marytts-lang-dsb-0.1.0.jar lib/
ADD https://repo1.maven.org/maven2/de/dfki/mary/marytts-lexicon-hsb/0.1.0/marytts-lexicon-hsb-0.1.0.jar lib/
ADD https://repo1.maven.org/maven2/de/dfki/mary/marytts-lang-hsb/0.1.0/marytts-lang-hsb-0.1.0.jar lib/
ADD https://repo1.maven.org/maven2/org/apache/commons/commons-csv/1.9.0/commons-csv-1.9.0.jar lib/

HEALTHCHECK CMD curl --fail http://localhost:59125/version
