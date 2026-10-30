ARG osversion=bionic
FROM ubuntu:${osversion}

LABEL maintainer="foersterfrank@gmx.de" \
      description="Dockerfile providing a build and testing environment for AliTV" \
      version=1.0.0

RUN apt update \
    && apt install -y build-essential wget git cpanminus libxml2-dev libexpat1-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O - https://github.com/lastz/lastz/archive/1.04.00.tar.gz | tar xzvf -
RUN sed -i 's/ -Werror//' /lastz-1.04.00/src/Makefile
RUN cd /lastz-1.04.00 && make && LASTZ_INSTALL=/usr/bin make install

RUN git clone https://github.com/AliTVTeam/AliTV-perl-interface
RUN cd /AliTV-perl-interface && cpanm --force .

WORKDIR /data
ENTRYPOINT ["/AliTV-perl-interface/bin/alitv.pl"]

