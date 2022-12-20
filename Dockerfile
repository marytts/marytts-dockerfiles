FROM openjdk:8-slim AS builder

WORKDIR /work/marytts
ADD https://github.com/marytts/marytts/archive/master.tar.gz marytts.tar.gz

RUN tar -xzf marytts.tar.gz --strip-components 1
RUN ./gradlew installDist --parallel

FROM alpine

RUN apk add --no-cache openjdk8

WORKDIR /marytts
COPY --from=builder /work/marytts/build/install/marytts .

EXPOSE 59125/tcp
ENTRYPOINT /marytts/bin/marytts-server

ADD https://repo1.maven.org/maven2/de/dfki/mary/marytts-lexicon-dsb/0.1.0/marytts-lexicon-dsb-0.1.0.jar lib/
ADD https://repo1.maven.org/maven2/de/dfki/mary/marytts-lang-dsb/0.1.0/marytts-lang-dsb-0.1.0.jar lib/
ADD https://repo1.maven.org/maven2/de/dfki/mary/marytts-lexicon-hsb/0.1.0/marytts-lexicon-hsb-0.1.0.jar lib/
ADD https://repo1.maven.org/maven2/de/dfki/mary/marytts-lang-hsb/0.1.0/marytts-lang-hsb-0.1.0.jar lib/
ADD https://repo1.maven.org/maven2/org/apache/commons/commons-csv/1.9.0/commons-csv-1.9.0.jar lib/

COPY voice-serbski-institut-dsb-juro-0.1.0-SNAPSHOT-legacy.zip \
    voice-serbski-institut-hsb-matej-0.1.0-SNAPSHOT-legacy.zip download/
RUN find download -name voice-serbski-institut-\*.zip -exec unzip {} \;
