import { expect } from 'chai';
import luckySeven from './helpers/luckySeven';

const Luckyseven = artifacts.require('LuckySeven');

describe('SLARegistry', () => {
  let owner;
  let notOwner;
  let luckysevenContract;

  before(async () => {
    [owner, notOwner] = await web3.eth.getAccounts();
    luckysevenContract = await Luckyseven.new();
  });

  it('mat', async () => {
    const params = {
      b: 1,
      n: 2,
      mu: 3,
      p: 20,
      i: 7,
      j: 12,
    };
    const number = luckySeven(params);
    const onchainNumber = await luckysevenContract.generator(
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
