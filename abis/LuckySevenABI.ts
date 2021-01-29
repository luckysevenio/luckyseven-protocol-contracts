import { AbiItem } from "web3-utils/types";

export const LuckySevenABI: AbiItem[] = [
  {
    inputs: [
      { internalType: "uint256", name: "b", type: "uint256" },
      { internalType: "uint256", name: "n", type: "uint256" },
      { internalType: "uint256", name: "mu", type: "uint256" },
      { internalType: "uint256", name: "p", type: "uint256" },
      { internalType: "uint256", name: "i", type: "uint256" },
      { internalType: "uint256", name: "j", type: "uint256" },
    ],
    name: "generator",
    outputs: [{ internalType: "uint256", name: "O", type: "uint256" }],
    stateMutability: "pure",
    type: "function",
  },
];
