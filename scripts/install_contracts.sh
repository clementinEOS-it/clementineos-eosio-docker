#!/bin/bash
set -e # exit on failure of any "simple" command (excludes &&, ||, or | chains)
cd /opt/eosio.contracts-1.8.2
sudo ./build.sh -c /usr/opt/eosio.cdt/1.6.3 -e /usr/opt/eosio/2.0.7 -t -y
# cd build
# tar -pczf /artifacts/contracts.tar.gz *