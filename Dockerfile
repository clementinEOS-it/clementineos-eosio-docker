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

# RUN wget https://github.com/EOSIO/eosio.cdt/releases/download/v1.7.0/eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ./eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb

# RUN wget https://github.com/EOSIO/eosio.cdt/releases/download/v1.6.3/eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ./eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb

# create directory 
WORKDIR /opt/eosio
WORKDIR /opt/eosio/nodeos
# WORKDIR /opt/eosio/wallet
WORKDIR /opt/eosio/scripts

ENV EOSIO_ROOT=/opt/eosio

WORKDIR /opt/eosio/nodeos/config
# WORKDIR /opt/eosio/wallet/config

VOLUME /opt/eosio/nodeos
# VOLUME /opt/eosio/wallet

COPY ./scripts/nodeosd.sh /opt/eosio/scripts
RUN chmod +x /opt/eosio/scripts/nodeosd.sh

# COPY ./scripts/keosd.sh /opt/eosio/scripts
# RUN chmod +x /opt/eosio/scripts/keosd.sh

# Install Contracts
# RUN cd /opt && git clone https://github.com/EOSIO/eosio.contracts
# RUN cd /opt && wget https://github.com/EOSIO/eosio.contracts/archive/v1.8.2.tar.gz
# RUN tar -xf /opt/v1.8.2.tar.gz
# RUN cd /opt/eosio.contracts  
# RUN sudo ./build.sh -c /usr/opt/eosio.cdt/1.6.3 -e /usr/opt/eosio/2.0.7 -t -y

#COPY ./scripts/install_contracts.sh /opt/eosio/scripts
#RUN chmod +x /opt/eosio/scripts/install_contracts.sh
#RUN sudo /opt/eosio/scripts/install_contracts.sh
