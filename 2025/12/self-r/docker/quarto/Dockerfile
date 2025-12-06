FROM rocker/tidyverse:4.5.2

RUN apt update && apt install -y \
    libxt6 \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN install2.r --error \
    reticulate

RUN installGithub.r --update=FALSE \
    igjit/rm1@4115c80
