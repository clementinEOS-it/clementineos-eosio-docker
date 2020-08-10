FROM ubuntu:18.04

# ----------------------------------------------------
LABEL author="Giuseppe Zileni <giuseppe.zileni@gmail.com>" maintainer="Giuseppe Zileni <giuseppe.zileni@gmail.com>" version="2.0.0" \
  description="This is a base image for building eosio/eos"

# ----------------------------------------------------
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo apt-utils wget curl net-tools ca-certificates unzip cmake git openssl libusb-1.0-0 build-essential libbz2-dev zlib1g-dev libssl-dev libgmp3-dev libicu-dev bc && rm -rf /var/lib/apt/lists/*

# Install latest eosio 
RUN wget https://github.com/EOSIO/eos/releases/download/v2.0.7/eosio_2.0.7-1-ubuntu-18.04_amd64.deb
RUN DEBIAN_FRONTEND=noninteractive apt install -y ./eosio_2.0.7-1-ubuntu-18.04_amd64.deb

# create directory 
WORKDIR /opt/eosio
WORKDIR /opt/eosio/nodeos
WORKDIR /opt/eosio/scripts

ENV EOSIO_ROOT=/opt/eosio

WORKDIR /opt/eosio/nodeos/config

VOLUME /opt/eosio/nodeos

ENV DATA_DIR /opt/nodeos/data
ENV DATA_CONFIG /opt/nodeos/config

COPY ./scripts/nodeosd.sh /opt/eosio/scripts
RUN chmod +x /opt/eosio/scripts/nodeosd.sh

