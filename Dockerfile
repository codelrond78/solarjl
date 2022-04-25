FROM julia:1.8.0-beta3-bullseye

ENV PORT "8080"

RUN apt -y update
RUN apt -y upgrade
#RUN yes | apt install git
RUN apt install -y git curl docker.io

