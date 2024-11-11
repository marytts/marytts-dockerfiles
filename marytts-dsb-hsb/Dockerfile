FROM eclipse-temurin:8-jdk-noble AS builder

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -qq install \
      unzip

WORKDIR /work/marytts
ADD --checksum=sha256:c43c4e52ab0ab2e3d9a2709456bd01578f66f36a719d2ffd0919734a86d4d77d \
    https://github.com/marytts/marytts/archive/1c2aaa0751b7cef8ae83216dd78b4c61232b3840.tar.gz \
    marytts.tar.gz

RUN tar -xzf marytts.tar.gz --strip-components 1
RUN ./gradlew installDist --parallel

WORKDIR /work/marytts/build/install/marytts
ADD --checksum=sha256:2a5620239008d4f1cb762f59ebda2482d12a04fdddf7d51f51ef068b8504e96c \
    https://github.com/marytts/voice-serbski-institut-dsb-juro/releases/download/v0.1.0-beta5/voice-serbski-institut-dsb-juro-0.1.0-beta5-legacy.zip \
    download/
ADD --checksum=sha256:02483e71c825d2a5a27b269c6efcfe312a384c2c0e9440759f5040367be6d056 \
    https://github.com/marytts/voice-serbski-institut-hsb-matej/releases/download/v0.1.0-beta5/voice-serbski-institut-hsb-matej-0.1.0-beta5-legacy.zip \
    download/
RUN find download/ -name voice-serbski-institut-\*.zip \
      -exec unzip {} \; \
      -delete

ADD --checksum=sha256:9b2b10846d9da1d51e128abe018aa9cff7b917c0882c7ab00d2d3d4c5f9af3f8 \
  https://repo1.maven.org/maven2/de/dfki/mary/marytts-lexicon-dsb/0.2.1/marytts-lexicon-dsb-0.2.1.jar lib/
ADD --checksum=sha256:7bf3c69f9b792a4d7ee376e26c57d65a934a0d05cce43d5c9ca8f05f16a3d6b3 \
  https://repo1.maven.org/maven2/de/dfki/mary/marytts-lang-dsb/0.2.1/marytts-lang-dsb-0.2.1.jar lib/
ADD --checksum=sha256:1857c8e2309b50ba5d680465edfe681b91627e761e70e47984c036b2fb3b1c3b \
  https://repo1.maven.org/maven2/de/dfki/mary/marytts-lexicon-hsb/0.2.0/marytts-lexicon-hsb-0.2.0.jar lib/
ADD --checksum=sha256:846f6e7d40b0737041d392e1f31260349637f29215ff2b89cdbc1c1e7d995d77 \
  https://repo1.maven.org/maven2/de/dfki/mary/marytts-lang-hsb/0.2.1/marytts-lang-hsb-0.2.1.jar lib/
ADD --checksum=sha256:c418d6aab4db4f1f70983d355de8d7c1e755c754820a92294da2e5f5081022cc \
  https://repo1.maven.org/maven2/org/apache/commons/commons-csv/1.9.0/commons-csv-1.9.0.jar lib/

FROM alpine:3.20

RUN apk add --no-cache \
    curl \
    openjdk8

WORKDIR /marytts
COPY --from=builder /work/marytts/build/install/marytts .

EXPOSE 59125/tcp
ENV JAVA_OPTS="-Dlog4j.logger.marytts=INFO,stderr -Dsocket.addr=0.0.0.0"
ENTRYPOINT ["/marytts/bin/marytts-server"]

HEALTHCHECK CMD ["curl", "--fail", "http://localhost:59125/version"]
