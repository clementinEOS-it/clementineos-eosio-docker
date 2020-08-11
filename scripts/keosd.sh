#!/bin/sh

exec sudo keosd --wallet-dir=/opt/eosio/wallet/data --config-dir=/opt/eosio/wallet/config >> keosd.log 2>&1 &
