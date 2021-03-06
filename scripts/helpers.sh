#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

WALLET_KEYS=/opt/eosio/wallet/keys

# Alias cleos with endpoint param to avoid repetition
cleos="cleos -u http://ec2-3-8-20-64.eu-west-2.compute.amazonaws.com:8888 --wallet-url http://ec2-3-8-20-64.eu-west-2.compute.amazonaws.com:8901"
# cleos="cleos -u http://localhost:8888 --wallet-url http://localhost:8901"

# Unlocks the default wallet and waits .5 seconds
function unlock_wallet () {
  echo "Unlocking defaault wallet..."
  $cleos wallet unlock --password $(cat $WALLET_KEYS/wallet_password.txt)
  sleep .5
}

# Creates the default wallet and stores the password on a file
function create_wallet () {
  echo "Creating default wallet ..."
  $cleos wallet create --to-console | awk 'FNR > 3 { print $1 }' | tr -d '"' > $WALLET_KEYS/wallet_password.txt
  # WALLET_PASSWORD=$($cleos wallet create --to-console | awk 'FNR > 3 { print $1 }' | tr -d '"')
  # echo $WALLET_PASSWORD > $WALLET_KEYS/wallet_password.txt
  sleep .5
}

# Helper function to import private key into the eoslocal wallet
function import_private_key () {
  $cleos wallet import --private-key $1
}

# Creates an eos account with 100 EOS
function create_eos_account () {
  # $cleos system newaccount eosio --transfer $1 $2 $2 --stake-net '1 EOS' --stake-cpu '1 EOS' --buy-ram '1 EOS'
  $cleos create account eosio $1 $2 $2
  $cleos transfer eosio $1 '100 EOS' -p eosio
}
