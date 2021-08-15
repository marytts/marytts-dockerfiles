# MaryTTS Docker image for Sorbian languages

## Prerequisites

Docker must be installed.

Ensure that this repository is cloned with all nested submodules:

    git clone --recurse-submodules git@github.com:Sorbisches-Institut/marytts-docker.git

Alternatively if already cloned, ensure that all nested submodules are initalized and up-to-date:

    git submodule update --recursive --init

## Building the image

Run

    docker build -t marytts-hsb .

## Running the container

Run

    docker run -it --rm -p 59125:59125 marytts-hsb

Then access MaryTTS via browser on the host at <http://localhost:59125>.
