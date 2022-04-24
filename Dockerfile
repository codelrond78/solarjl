FROM julia:1.8.0-beta3-bullseye

RUN yes | apt update
RUN yes | apt upgrade
RUN yes | apt install git