# VAIOT cli cheatsheet

## Unjailing a validator after being punished for downtime:

If your node remain offline for an extended period of time, you will be jailed and therefore won't participate in voting. After getting back online and syncing blockchain state, use the command below to resume voting.
```
vaiotd tx slashing unjail --from VALIDATOR_ADDRESS --chain-id vaiot -y
```

## Redelegating staking rewards

As a validator, you need a constant self delegation of VAIs, which means you earn rewards from staking. To withdraw your earned rewards and redelegate them, use the commands bellow.
```
vaiotd tx distribution withdraw-rewards VALIDATOR_ACCOUNT --from VALIDATOR_ADDRESS --chain-id vaiot -y
vaiotd tx staking delegate VALIDATOR_ACCOUNT AMOUNT --from VALIDATOR_ADDRESS --chain-id vaiot -y
```