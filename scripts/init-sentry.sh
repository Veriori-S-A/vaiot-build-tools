#!/usr/bin/env bash

rm -rdf /root/.vaiot
mkdir -p /root/.vaiot/cosmovisor/genesis/bin
mkdir /root/.vaiot/cosmovisor/upgrades
cp /go/bin/vaiotd /root/.vaiot/cosmovisor/genesis/bin
vaiotd init $MONIKER --chain-id vaiot
cp /config/app.toml /root/.vaiot/config
cp /config/client.toml /root/.vaiot/config
cp /config/config.toml /root/.vaiot/config
sed -i "s|moniker =.*|moniker = \"$MONIKER\"|g" /root/.vaiot/config/config.toml
vaiotd tendermint show-node-id