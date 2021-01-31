import { expect } from 'chai';
import luckySeven from './helpers/luckySeven';

const LuckySevenPRNG = artifacts.require('LuckySevenPRNG');

describe('LuckySevenPRNG', () => {
  let owner;
  let notOwner;
  let luckysevenContract;

  before(async () => {
    [owner, notOwner] = await web3.eth.getAccounts();
    luckysevenContract = await LuckySevenPRNG.new();
  });

  it('it should calculate the random number on chain', async () => {
    const params = {
      b: 1,
      n: 2,
      mu: 3,
      p: 20,
      i: 7,
      j: 12,
    };
    const number = luckySeven(params);
    const onchainNumber = await luckysevenContract.prng(
      params.b,
      params.n,
      params.mu,
      params.p,
      params.i,
      params.j,
    );
    expect(number.toString()).to.equal(onchainNumber.toString());
  });
});
