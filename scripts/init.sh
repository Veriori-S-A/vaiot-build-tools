#!/usr/bin/env bash

rm -rdf /root/.vaiot
mkdir -p /root/.vaiot/cosmovisor/genesis/bin
mkdir /root/.vaiot/cosmovisor/upgrades
cp /go/bin/vaiotd /root/.vaiot/cosmovisor/genesis/bin
vaiotd init $MONIKER --chain-id vaiot
vaiotd config keyring-backend file
(echo $KEYPASSWD; echo $KEYPASSWD) | vaiotd keys add --keyring-backend file $USER 2>&1 | tail -1 >> /root/priv_key.txt
echo $KEYPASSWD | vaiotd add-genesis-account --keyring-backend file $USER "1000000000000000000000vai"
echo "$KEYPASSWD" | vaiotd gentx $USER "1000000000000000000000vai" \
--chain-id="vaiot" --commission-rate="0.07" --commission-max-rate="1.0" --commission-max-change-rate="0.01" \
--min-self-delegation="100" --keyring-backend file \
--identity="$IDENTITY" --security-contact="$CONTACT" --website="$WEBSITE" --details="$DETAILS"
curl -F "file=@$(ls /root/.vaiot/config/gentx/gentx-*.json)" https://file.io | jq '.link' -r