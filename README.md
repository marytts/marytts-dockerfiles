# MaryTTS Docker image for Sorbian languages

## Prerequisites

Docker must be installed.

## Building the image

Run

    docker build -t marytts-hsb-dsb .

## Running the container

Run

    docker run -it --rm -p 59125:59125 marytts-hsb-dsb

Then access MaryTTS via browser on the host at <http://localhost:59125>.
