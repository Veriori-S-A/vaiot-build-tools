#!/usr/bin/env bash

if ! [ -x "$(command -v docker)" ]; then
    echo "Install Docker before running this script."
    exit
fi

echo "Greetings VAIOT Validator! We need some basic information to initialize your sentry node."

echo -n "Moniker (basically a name for your node, e.g. your company name, but make sure it's UNIQUE for every node): "
read -r MONIKER

echo
echo -n "Initializing environment.."
echo

FILE=$(docker run -it -e MONIKER="$MONIKER" \
--rm -a stdout -v ${PWD}:/root balciu/vaiot-sentry:v1.0 | tail -1)

echo -n "You've successfully initialized your sentry node!"
echo -n "Bellow you will find your node ID, which you must include in unconditional_peer_ids of your validator's config.toml:"
echo
echo $FILE