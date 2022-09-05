FROM rocker/r-ubuntu:22.04

ADD Rprofile.site /usr/lib/R/etc/Rprofile.site

RUN apt-get update \
 && apt-get upgrade -y

RUN install.r devtools rmarkdown tidyverse gifski \
 && installGithub.r rundel/checklist rundel/parsermd

RUN apt-get install -y --no-install-recommends \
    libudunits2-dev libgdal-dev libgeos-dev \
    libproj-dev pandoc libmagick++-dev \
    libglpk-dev libnode-dev

RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
