#!/usr/bin/env bash

if ! [ -x "$(command -v docker)" ]; then
    echo "Install Docker before running this script."
    exit
fi

echo "Greetings VAIOT Validator! We need some basic information before we can initialize the environment for hosting VAIOT node."

echo -n "Moniker (basically a name for your node, e.g. your company name): "
read -r MONIKER

while true; do
    echo -n "Private key password (you will use it to send transactions to the blockchain using your validator account): "
    read -r -s KEYPASSWD
    echo
    if [ ${#KEYPASSWD} -lt 8 ]; then
        echo -n "Password must be at least 8 characters long"
        echo
        continue
    fi
    echo -n "Confirm password: "
    read -r -s PASS
    echo
    [ "$KEYPASSWD" = "$PASS" ] && break
    echo -n "Passwords did not match. Please try again."
    echo
done

echo -n "Account name (it will be used to identify your account private key in the keyring): "
read -r USER

echo -n "Identity (e.g. company name): "
read -r IDENTITY

echo -n "Node admin e-mail: "
read -r CONTACT

echo -n "Details (short description of you or your validator :) ): "
read -r DETAILS
echo
echo -n "Initializing environment.."
echo

FILE=$(docker run -it -e MONIKER="$MONIKER" -e KEYPASSWD="$KEYPASSWD" -e USER="$USER" -e IDENTITY="$IDENTITY" -e CONTACT="$CONTACT" -e WEBSITE="$WEBSITE" -e DETAILS="$DETAILS" \
--rm -a stdout -v ${PWD}:/root balciu/vaiot-init:v1.0 | tail -1)

echo -n "You've successfully initialized your environment! Please copy and store safely your mnemonic (wallet key) that was saved into priv_key.txt file in your current directory. If you lose it, you won't be able to regain control of your validator node!"
echo -n "Bellow is the link, where your genesis transaction was uploaded. Please share it with your VAIOT contact!"
echo
echo $FILE