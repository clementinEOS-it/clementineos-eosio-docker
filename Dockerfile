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

RUN wget https://github.com/eosio/eosio.cdt/releases/download/v1.7.0/eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb
RUN DEBIAN_FRONTEND=noninteractive apt install -y ./eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb

# create directory 
WORKDIR /opt/eosio
WORKDIR /opt/eosio/nodeos
WORKDIR /opt/eosio/nodeos/data
WORKDIR /opt/eosio/nodeos/config

ENV EOSIO_ROOT=/opt/eosio

VOLUME /opt/eosio/nodeos

ENV DATA_DIR /opt/nodeos/data
ENV DATA_CONFIG /opt/nodeos/config

# ----------------------------------------------------
# ARG branch=master
# ARG symbol=SYS

# ----------------------------------------------------
# RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
#  && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
#  && apt-get update \
#  && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo apt-utils wget curl net-tools ca-certificates unzip cmake git openssl libusb-1.0-0 build-essential libbz2-dev zlib1g-dev libssl-dev libgmp3-dev libicu-dev bc && rm -rf /var/lib/apt/lists/*

# Clone eosio.cdt
# WORKDIR /opt
# RUN cd /opt \
#    && sudo git clone -b ${branch} https://github.com/eosio/eosio.cdt --recursive

# Checkout eosio.cdt
# RUN cd /opt/eosio.cdt && sudo git submodule update --recursive

# Build eosio.cdt
# RUN sudo /opt/eosio.cdt/scripts/eosiocdt_build.sh ${symbol}

# Install eosio.cdt
# RUN sudo /opt/eosio.cdt/scripts/eosiocdt_install.sh

WORKDIR /opt/eosio/wallet
WORKDIR /opt/eosio/wallet/data
WORKDIR /opt/eosio/wallet/config
WORKDIR /opt/eosio/wallet/config/keys

VOLUME /opt/eosio/wallet

# used by start.sh
ENV WALLET_DIR /opt/eosio/wallet/data
ENV WALLET_CONFIG /opt/eosio/wallet/config

## Add the wait script to the image
RUN cd /opt/eosio/ 
ADD ./utils/wait /wait
RUN chmod +x /wait




