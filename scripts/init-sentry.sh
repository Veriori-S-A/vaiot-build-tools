#!/usr/bin/env bash

rm -rdf /root/.vaiot
mkdir -p /root/.vaiot/cosmovisor/genesis/bin
mkdir /root/.vaiot/cosmovisor/upgrades
cp /go/bin/vaiotd /root/.vaiot/cosmovisor/genesis/bin
vaiotd init $MONIKER --chain-id vaiot
vaiotd tendermint show-node-id