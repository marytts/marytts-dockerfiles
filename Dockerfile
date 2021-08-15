FROM openjdk:8-jdk AS builder

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
    sox \
    speech-tools

COPY marytts-hsb-meta/ /work/marytts-hsb-meta/

WORKDIR /work/marytts-hsb-meta/marytts-lang-hsb
RUN ./gradlew build

WORKDIR /work/marytts-hsb-meta/voice-hsb-poc
RUN ../marytts-lang-hsb/gradlew build \
  && unzip build/distributions/*.zip

FROM psibre/marytts:5.2
COPY --from=builder \
  /work/marytts-hsb-meta/marytts-lang-hsb/build/libs/*.jar \
  /work/marytts-hsb-meta/marytts-lang-hsb/marytts-lexicon-hsb/build/libs/*.jar \
  /work/marytts-hsb-meta/voice-hsb-poc/lib/ \
  /marytts/lib/