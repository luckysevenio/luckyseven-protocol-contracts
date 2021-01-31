import { AbiItem } from 'web3-utils/types';

export const LuckySevenABI: AbiItem[] = [
  {
    inputs: [
      { internalType: 'address', name: '_chainlinkOracle', type: 'address' },
      { internalType: 'address', name: '_chainlinkToken', type: 'address' },
      { internalType: 'bytes32', name: '_chainlinkJobId', type: 'bytes32' },
    ],
    stateMutability: 'nonpayable',
    type: 'constructor',
  },
  {
    anonymous: false,
    inputs: [
      { indexed: true, internalType: 'bytes32', name: 'id', type: 'bytes32' },
    ],
    name: 'ChainlinkCancelled',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      { indexed: true, internalType: 'bytes32', name: 'id', type: 'bytes32' },
    ],
    name: 'ChainlinkFulfilled',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      { indexed: true, internalType: 'bytes32', name: 'id', type: 'bytes32' },
    ],
    name: 'ChainlinkRequested',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      { indexed: false, internalType: 'uint256', name: 'i', type: 'uint256' },
      {
        indexed: false,
        internalType: 'uint256',
        name: 'luckySevenNumber',
        type: 'uint256',
      },
      {
        indexed: true,
        internalType: 'address',
        name: 'owner',
        type: 'address',
      },
    ],
    name: 'IParameterReceived',
    type: 'event',
  },
  {
    inputs: [],
    name: 'chainlinkJobId',
    outputs: [{ internalType: 'bytes32', name: '', type: 'bytes32' }],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'chainlinkOracle',
    outputs: [{ internalType: 'address', name: '', type: 'address' }],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'fee',
    outputs: [{ internalType: 'uint256', name: '', type: 'uint256' }],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      { internalType: 'address', name: '', type: 'address' },
      { internalType: 'uint256', name: '', type: 'uint256' },
    ],
    name: 'luckySevenNumbersRegister',
    outputs: [
      { internalType: 'uint256', name: 'b', type: 'uint256' },
      { internalType: 'uint256', name: 'n', type: 'uint256' },
      { internalType: 'uint256', name: 'mu', type: 'uint256' },
      { internalType: 'uint256', name: 'p', type: 'uint256' },
      { internalType: 'uint256', name: 'i', type: 'uint256' },
      { internalType: 'uint256', name: 'j', type: 'uint256' },
      { internalType: 'uint256', name: 'number', type: 'uint256' },
      { internalType: 'bool', name: 'fulfilled', type: 'bool' },
      { internalType: 'address', name: 'owner', type: 'address' },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      { internalType: 'uint256', name: 'b', type: 'uint256' },
      { internalType: 'uint256', name: 'n', type: 'uint256' },
      { internalType: 'uint256', name: 'mu', type: 'uint256' },
      { internalType: 'uint256', name: 'p', type: 'uint256' },
      { internalType: 'uint256', name: 'i', type: 'uint256' },
      { internalType: 'uint256', name: 'j', type: 'uint256' },
    ],
    name: 'prng',
    outputs: [{ internalType: 'uint256', name: 'O', type: 'uint256' }],
    stateMutability: 'pure',
    type: 'function',
  },
  {
    inputs: [{ internalType: 'bytes32', name: '', type: 'bytes32' }],
    name: 'requestToLuckySevenNumber',
    outputs: [
      { internalType: 'uint256', name: 'b', type: 'uint256' },
      { internalType: 'uint256', name: 'n', type: 'uint256' },
      { internalType: 'uint256', name: 'mu', type: 'uint256' },
      { internalType: 'uint256', name: 'p', type: 'uint256' },
      { internalType: 'uint256', name: 'i', type: 'uint256' },
      { internalType: 'uint256', name: 'j', type: 'uint256' },
      { internalType: 'uint256', name: 'number', type: 'uint256' },
      { internalType: 'bool', name: 'fulfilled', type: 'bool' },
      { internalType: 'address', name: 'owner', type: 'address' },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [{ internalType: 'uint256', name: '', type: 'uint256' }],
    name: 'requests',
    outputs: [{ internalType: 'bytes32', name: '', type: 'bytes32' }],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      { internalType: 'uint256', name: '_b', type: 'uint256' },
      { internalType: 'uint256', name: '_n', type: 'uint256' },
      { internalType: 'uint256', name: '_mu', type: 'uint256' },
      { internalType: 'uint256', name: '_p', type: 'uint256' },
      { internalType: 'uint256', name: '_j', type: 'uint256' },
    ],
    name: 'requestInsecureIParameter',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [
      { internalType: 'bytes32', name: '_requestId', type: 'bytes32' },
      { internalType: 'bytes32', name: '_chainlinkResponse', type: 'bytes32' },
    ],
    name: 'fulFillInsecureIParameter',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
];
