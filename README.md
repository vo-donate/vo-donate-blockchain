# 📘 Smart Contract Documentation

## Contract Address

Registry contract: `0x70704277Fa803BB7d0C519f981fd4e1a63325c22`

DonationFactory contract: `0x81a3261f9da6D5F240660068a69a2240b35751Ae`

RPC_URL: `https://public-en-kairos.node.kaia.io`

투표 시 `1000 wei`를 필수로 보내야함

**투표 성공 조건**: `voteCount * 3 >= voterCount * 2` 

**기부는 투표 통과 후에만 가능**하며, 제안자는 기부 마감 이후에만 금액을 인출 가능

`donate()`에서 중복 기부자는 `donors`에 중복 저장되지 않음

## Contract ABI

### `MemberRegistry`

| 기능 설명 | 함수 이름 | 입력값 | 출력값 | 상태 변경 | payable |
| --- | --- | --- | --- | --- | --- |
| 회원 등록 | `register()` | ❌ | ❌ | ✅ | ❌ |
| 회원 삭제 | `unregister()` | `address _user` | ❌ | ✅ | ❌ |
| 회원 주소 조회 | `getAllMembers()` | ❌ | `address[]`  | ❌ | ❌ |
| 회원 수 조회 | `getMemberCount()` | ❌ | `uint256` | ❌ | ❌ |

---

```json
{
  "abi": [
    { "type": "constructor", "inputs": [], "stateMutability": "nonpayable" },
    {
      "type": "function",
      "name": "getAllMembers",
      "inputs": [],
      "outputs": [
        { "name": "", "type": "address[]", "internalType": "address[]" }
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getMemberCount",
      "inputs": [],
      "outputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "isMember",
      "inputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "outputs": [{ "name": "", "type": "bool", "internalType": "bool" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "member",
      "inputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "outputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "owner",
      "inputs": [],
      "outputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "register",
      "inputs": [
        { "name": "_user", "type": "address", "internalType": "address" }
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "unregister",
      "inputs": [
        { "name": "_user", "type": "address", "internalType": "address" }
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    }
  ]
}

```

---

### `DonationProposalFactory`

| 기능 설명 | 함수 이름 | 입력값 | 출력값 | 상태 변경 | payable |
| --- | --- | --- | --- | --- | --- |
| 제안 생성 | `createProposal()` | `string _text`
`uint256 donationDurationInMinutes` | ❌ | ✅ | ❌ |
| 생성된 제안 목록 조회 | `getProposals()` | ❌ | `address[]` | ❌ | ❌ |
| 레지스트리 주소 조회 | `registryAddress()` | ❌ | `address` | ❌ | ❌ |

> 💡 제안 생성 시 ProposalCreated 이벤트가 발생합니다.
> 

---

```json
{
  "abi": [
    {
      "type": "constructor",
      "inputs": [
        {
          "name": "_registryAddress",
          "type": "address",
          "internalType": "address"
        }
      ],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "createProposal",
      "inputs": [
        { "name": "_text", "type": "string", "internalType": "string" },
        {
          "name": "voteDurationInMinutes",
          "type": "uint256",
          "internalType": "uint256"
        },
        {
          "name": "donationDurationInMinutes",
          "type": "uint256",
          "internalType": "uint256"
        }
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "deployedProposals",
      "inputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "outputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getProposals",
      "inputs": [],
      "outputs": [
        { "name": "", "type": "address[]", "internalType": "address[]" }
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "registryAddress",
      "inputs": [],
      "outputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "stateMutability": "view"
    },
    {
      "type": "event",
      "name": "ProposalCreated",
      "inputs": [
        {
          "name": "proposalAddress",
          "type": "address",
          "indexed": false,
          "internalType": "address"
        },
        {
          "name": "proposer",
          "type": "address",
          "indexed": false,
          "internalType": "address"
        },
        {
          "name": "text",
          "type": "string",
          "indexed": false,
          "internalType": "string"
        },
        {
          "name": "voteDeadline",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        },
        {
          "name": "donationDeadline",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        }
      ],
      "anonymous": false
    }
  ]
}

```

---

### `DonationProposal`

| 기능 설명 | 함수 이름 | 입력값 | 출력값 / 설명 | 상태 변경 | payable |
| --- | --- | --- | --- | --- | --- |
| 투표 참여 | `vote()` | `bool approve` | ❌ | ✅ | `1000 wei` |
| 투표 결과 확정 | `finalizeVote()` | ❌ | ❌ | ✅ | ❌ |
| 기부 | `donate()` | `msg.value` | ❌ | ✅ | ✅ |
| 제안자가 기부금 수령 | `withdraw()` | ❌ | ❌ | ✅ | ❌ |
| 제안 요약 정보 조회 | `getSummary()` | ❌ | `address proposer
string text
uint totalDonation
bool finalized
uint voteCount
uint voterCount
uint balance
bool votePassed
uint donationEndTime` | ❌ | ❌ |
| 제안자 주소 조회 | `proposer()` | ❌ | `address` | ❌ | ❌ |
| 제안 내용 조회 | `proposalText()` | ❌ | `string` | ❌ | ❌ |

---

```json
{
  "abi": [
    {
      "type": "constructor",
      "inputs": [
        { "name": "_proposer", "type": "address", "internalType": "address" },
        { "name": "_text", "type": "string", "internalType": "string" },
        { "name": "_registry", "type": "address", "internalType": "address" },
        {
          "name": "_voteDurationMinutes",
          "type": "uint256",
          "internalType": "uint256"
        },
        {
          "name": "_donationDurationMinutes",
          "type": "uint256",
          "internalType": "uint256"
        }
      ],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "STAKE_AMOUNT",
      "inputs": [],
      "outputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "donate",
      "inputs": [],
      "outputs": [],
      "stateMutability": "payable"
    },
    {
      "type": "function",
      "name": "donationEndTime",
      "inputs": [],
      "outputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "donations",
      "inputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "outputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "donors",
      "inputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "outputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "endTime",
      "inputs": [],
      "outputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "finalizeVote",
      "inputs": [],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "finalized",
      "inputs": [],
      "outputs": [{ "name": "", "type": "bool", "internalType": "bool" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getSummary",
      "inputs": [],
      "outputs": [
        { "name": "", "type": "address", "internalType": "address" },
        { "name": "", "type": "string", "internalType": "string" },
        { "name": "", "type": "uint256", "internalType": "uint256" },
        { "name": "", "type": "bool", "internalType": "bool" },
        { "name": "", "type": "uint256", "internalType": "uint256" },
        { "name": "", "type": "uint256", "internalType": "uint256" },
        { "name": "", "type": "uint256", "internalType": "uint256" },
        { "name": "", "type": "bool", "internalType": "bool" },
        { "name": "", "type": "uint256", "internalType": "uint256" }
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "hasVoted",
      "inputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "outputs": [{ "name": "", "type": "bool", "internalType": "bool" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "proposalText",
      "inputs": [],
      "outputs": [{ "name": "", "type": "string", "internalType": "string" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "proposer",
      "inputs": [],
      "outputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "registry",
      "inputs": [],
      "outputs": [
        {
          "name": "",
          "type": "address",
          "internalType": "contract MemberRegistry"
        }
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "totalDonation",
      "inputs": [],
      "outputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "vote",
      "inputs": [{ "name": "approve", "type": "bool", "internalType": "bool" }],
      "outputs": [],
      "stateMutability": "payable"
    },
    {
      "type": "function",
      "name": "voteCount",
      "inputs": [],
      "outputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "votePassed",
      "inputs": [],
      "outputs": [{ "name": "", "type": "bool", "internalType": "bool" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "voterCount",
      "inputs": [],
      "outputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "voters",
      "inputs": [{ "name": "", "type": "uint256", "internalType": "uint256" }],
      "outputs": [{ "name": "", "type": "address", "internalType": "address" }],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "withdraw",
      "inputs": [],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "withdrawn",
      "inputs": [],
      "outputs": [{ "name": "", "type": "bool", "internalType": "bool" }],
      "stateMutability": "view"
    }
  ]
}

```

---

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Deploy.s.sol:DeployScript --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast --verify --chain 1001
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

### Logs

```shell
$ Registry deployed at: 0x6c5833155dD6471E7F0F3569B206E6baa3717c8c
$ Factory deployed at: 0x23a0854C507E5f6dd91215f83D0b9885ED674F4e
```
