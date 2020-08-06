#!/bin/sh

exec sudo nodeos -e --data-dir=/opt/eosio/nodeos --config-dir=/opt/eosio/nodeos/config --disable-replay-opts --contracts-console --hard-replay-blockchain --delete-all-blocks >> nodeos.log 2>&1 &
