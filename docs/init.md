# VAIOT genesis phase manual

## Initializing the environment

### 1. Place `init.sh` file in a chosen directory where you wish to place all the necessary blockchain node files. 
<br />

### 2. Make sure you have Docker installed, then run `init.sh` and follow the on-screen instructions.

#### If something goes wrong, delete all newly created files and folders and try again. If the problem persists, get in touch with your VAIOT contact.
<br />

### 3. If the script finished successfuly, it should return a similar message:
```
You've successfully initialized your environment! Please copy and store safely your mnemonic (wallet key) that was saved into priv_key.txt file in your current directory. If you lose it, you won't be able to regain control of your validator node!Bellow is the link, where your genesis transaction was uploaded. Please share it with your VAIOT contact!
https://file.io/zLoEf80a78UD
```

Please copy the returned url and send it your VAIOT contact. It contains a genesis transaction signed by your validator account.

<br />

### 4. Make sure to backup the contents of `priv_key.txt` file that was created in the same directory you run `init.sh` script.
<br />

### 5. Save the password you used in the initialization phase, as you will be required to use it for any transaction you'll want to broadcast to the network.

<br />

## Setting up your node(s)

You can either choose to configure a standalone machine as a validator or use sentry architecture for extra security. To read more about sentry architecture, click [here](https://docs.tendermint.com/master/nodes/validators.html)


### 1a. Sentry architecture

First, configure your network as shown [here](https://docs.tendermint.com/master/nodes/validators.html#local-configuration). Next, to initialize sentry nodes, use the `bootstrap-sentry.sh`, which will output sentry's node id. Save it for later. <br />
After you initialized all your sentry nodes, start your validator container using command:
```
docker-compose up -d
```
Now, get your validator's node id, by typing:
```
docker-compose exec vaiot bash -c '~/.vaiot/cosmovisor/genesis/bin/vaiotd tendermint show-node-id'
```
Now you have all your node's ids, so it's time to set necessary options in `.vaiot/config/config.toml` of every node. <br />
For sentry nodes, use the following:
```
pex = true
unconditional_peer_ids = <validator node id>
persistent_peers = <validator nodes, optionally other sentry nodes> (e.g. "f61215bae612a6361958002d9f4a7d6170afe84b@10.0.1.2:26656,59d49e39d507bb190e746bcf5590d65879c132e2@185.32.231.48:26656")
private_peer_ids = <validator node id>
addr_book_strict = false
external_address = <your-public-address> (e.g: tcp://58.182.46.62:26656>
```
Please share your `external_address` with other validators, so they can include them in `persistent_peers` of `config.toml`. <br />

For validator node, use the following:
```
pex = false
unconditional_peer_ids = <list of sentry node id's> (separeted by comma)
persistent_peers = <sentry nodes> (e.g. "f61215bae612a6361958002d9f4a7d6170afe84b@10.0.1.2:26656")
```

Make sure to collect some of other validator's public addresses and include them in `persistent_peers`. You're now ready for launch!

### 1b. Standalone validator architecture

Start your validator container using a script bellow. Remember to have `docker-compose.yml` file in the same directory where `.vaiot` is.
```
docker-compose up -d
```
Get your node id and share it with other validators, so they will be able to connect with you directly:
```
docker-compose exec vaiot bash -c '~/.vaiot/cosmovisor/genesis/bin/vaiotd tendermint show-node-id'
```
Now, set `.vaiot/config/config.toml` properly by editing these properties:
```
pex = true
unconditional_peer_ids = <other node id's> (separeted by comma)
persistent_peers = <other nodes> (e.g. "f61215bae612a6361958002d9f4a7d6170afe84b@58.182.46.62:26656,59d49e39d507bb190e746bcf5590d65879c132e2@185.32.231.48:26656")
external_address = <your-public-address> (e.g: tcp://58.182.46.62:26656>
```
You're now ready for the last step of the configuration process.

<br />

## Starting the network

Download the common `genesis.json` file shared by VAIOT Team and place it in `.vaiot/config` directory of every node.<br />
### Launching validator node
Now, restart your node container and launch VAIOT daemon using cosmovisor tool:
```
docker-compose restart vaiot && docker-compose exec -d vaiot bash -c 'cosmovisor start'
```
### (optional) Launching sentry node

When launching sentry node, add `--rpc.laddr tcp://0.0.0.0:26657` to the cosmovisor:
```
docker-compose restart vaiot && docker-compose exec -d vaiot bash -c 'cosmovisor start --rpc.laddr tcp://0.0.0.0:26657'
```

### Check node status

Use command below to check your node status:
```
docker-compose exec vaiot bash -c 'vaiotd status 2>&1 | jq '{catching_up: .SyncInfo.catching_up, voting_power: .ValidatorInfo.VotingPower}''
```
If `voting_power` is greater than 0 and `catching_up` is false, your validator is live. If `catching_up` is true, you might have to wait to sync remaining blocks that were mined before you joined.