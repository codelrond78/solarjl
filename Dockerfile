FROM julia:1.8.0-beta3-bullseye

ENV PORT "8080"

RUN yes | apt update
RUN yes | apt upgrade
RUN yes | apt install git

