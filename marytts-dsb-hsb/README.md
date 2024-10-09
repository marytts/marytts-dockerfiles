# MaryTTS Docker image for Sorbian languages

[![Docker Image Version](https://img.shields.io/docker/v/marytts/marytts-dsb-hsb)](https://hub.docker.com/r/marytts/marytts-dsb-hsb)

## Prerequisites

Docker must be installed.

## Building the image

Run

    docker build -t marytts/marytts-dsb-hsb . \
        --platform linux/amd64,linux/arm64

Omit the `--platform` if your Docker Engine does not support multi-architecture building.

## Running the container

Run

    docker run -it --rm -p 59125:59125 marytts/marytts-hsb-dsb

Then access MaryTTS via browser on the host at <http://localhost:59125>.
