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

### 1a. Sentry architecture

TODO (genesis.json, config.toml)

### 1b. Standalone validator architecture

TODO (genesis.json, config.toml)

<br />

## Running your node(s)

TODO (compose)