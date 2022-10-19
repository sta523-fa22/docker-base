FROM rocker/r-ubuntu:22.04

ADD Rprofile.site /usr/lib/R/etc/Rprofile.site

RUN apt-get update \
 && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
    libudunits2-dev libgdal-dev libgeos-dev \
    libproj-dev pandoc libmagick++-dev \
    libglpk-dev libnode-dev \
    wget \
    && sed 's/value="1GiB"/value="8GiB"/1' /etc/ImageMagick-6/policy.xml > /etc/ImageMagick-6/policy.xml

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.1.189/quarto-1.1.189-linux-amd64.deb \
    && DEBIAN_FRONTEND=noninteractive apt install ./quarto-1.1.189-linux-amd64.deb \
    && rm quarto-1.1.189-linux-amd64.deb

RUN install.r devtools rmarkdown quarto tidyverse gifski \
 && installGithub.r rundel/checklist rundel/parsermd jl5000/barRacer

RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash"]

