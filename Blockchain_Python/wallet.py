import subprocess
import pandas as pd
import os
import json
from bit import wif_to_key
from dotenv import load_dotenv
from web3 import Web3
from web3.middleware import geth_poa_middleware
from eth_account import Account
from constants import *

def derive_wallets ():
    types= [ETH, BTCTEST, BTC]
    mnemonic = os.getenv('MNEMONIC')
    coins = {}
    for i in types:
        command=f'php derive -g --mnemonic=mnemonic --cols=path,address,privkey,pubkey,pubkeyhash,xprv,xpub,index --format=json --numderive=3 --coin={i}'
        p = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
        (output, err)= p.communicate()
        keys = json.loads(output)
        coins.update({i:keys})
    return coins

coins=derive_wallets()

def priv_key_to_account(coin, coins):
    if coin==ETH:
        privkey=coins[coin][0]['privkey']
        return Account.privateKeyToAccount(key)
    elif coin==BTCTEST:
        privkey=coins[coin][0]['privkey']

def create_raw_tx(coin, account, recipient, amount):
    if coin == ETH:
        gasEstimate = w3.eth.estimateGas(
            {"from": account.address, "to": recipient, "value": amount}
        )
        return {
            "from": account.address,
            "to": recipient,
            "value": amount,
            "gasPrice": w3.eth.gasPrice,
            "gas": gasEstimate,
            "nonce": w3.eth.getTransactionCount(account.address),
        }
    elif coin==BTCTEST:
        return account.create_transaction([(to, amount, BTC)])
