FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    graphviz \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/jgm/pandoc/releases/download/2.11.4/pandoc-2.11.4-1-amd64.deb

RUN dpkg -i pandoc-2.11.4-1-amd64.deb && rm pandoc-2.11.4-1-amd64.deb

RUN useradd -m -s /bin/bash app

USER app
