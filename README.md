## Unhacked Challenge :: Reaper Farm • [![ci](https://github.com/whitenois3/reaper/actions/workflows/test.yml/badge.svg)](https://github.com/whitenois3/reaper/actions/workflows/test.yml) ![license](https://img.shields.io/github/license/whitenois3/reaper?label=license) ![solidity](https://img.shields.io/badge/solidity-^0.8.0-lightgrey)

`08/22/2022`

#### Reaper Farm

[Reaper Farm](https://www.reaper.farm/) is a yield aggregator on fantom. their V2 vaults were hacked on 8/2.

There were a number of implementations of the vaults with damages totalling $1.7mm, but the exploit was the same on all of them, so let's just focus on one — a DAI vault hacked for over $400k.

- vault: [0x77dc33dC0278d21398cb9b16CbFf99c1B712a87A](https://ftmscan.com/address/0x77dc33dc0278d21398cb9b16cbff99c1b712a87a)
- fantom dai: [0x8D11eC38a3EB5E956B052f67Da8Bdc9bef8Abf3E](https://ftmscan.com/address/0x8D11eC38a3EB5E956B052f67Da8Bdc9bef8Abf3E)

Review the code in this repo, find the exploit, and recover > $400k.

#### How to play

1. fork this repo and clone it locally.

2. update the .env file with an environment variable for FANTOM_RPC (already preset to the public RPC endpoint, which should work fine, in which case you can skip this).

3. review the code in the `src/` folder, which contains all the code at the time of the hack. you can explore the state of the contract before the hack using block 44000000. ex: `cast call --rpc-url ${FANTOM_RPC} --block 44000000 0x77dc33dC0278d21398cb9b16CbFf99c1B712a87A "totalAssets()" | cast 2d`

4. when you find an exploit, code it up in `ReaperHack.t.sol`. the test will pass if you succeed.

5. post on twitter for bragging rights and tag [@unhackedctf](http://twitter.com/unhackedctf). no cheating.

#### Shilling @unhacked

For new weekly challenges and solutions, subscribe to the [unhacked newsletter](https://unhackedctf.substack.com/publish/post/69864558).