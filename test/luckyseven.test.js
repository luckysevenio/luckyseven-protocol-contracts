import { expect } from 'chai';
import luckySeven from './helpers/luckySeven';
import { envParameters, needsGetJobId } from '../environments';
import getChainlinkJobId from './helpers/getChainlinkJobId';
import { eventListener } from './helpers';

const LinkToken = artifacts.require('@openzeppelin/contracts/token/ERC20/IERC20');

const LuckySeven = artifacts.require('LuckySeven');
const params = {
  b: 1,
  n: 2,
  mu: 3,
  p: 20,
  i: 7,
  j: 12,
};

describe('LuckySeven', () => {
  let owner;
  let notOwner;
  let luckysevenContract;
  let chainlinkToken;

  before(async () => {
    [owner, notOwner] = await web3.eth.getAccounts();
    luckysevenContract = await LuckySeven.new(
      envParameters.chainlinkOracleAddress,
      envParameters.chainlinkTokenAddress,
      !needsGetJobId ? envParameters.chainlinkJobId : await getChainlinkJobId(),
    );
    chainlinkToken = await LinkToken.at(envParameters.chainlinkTokenAddress);
  });

  it('it should ask for a random number insecurely and calculate the value correctly', async () => {
    // Add link tokens to LuckySeven contract to call Chainlink
    await chainlinkToken.transfer(luckysevenContract.address, web3.utils.toWei('0.1'));

    luckysevenContract.requestInsecureIParameter(
      params.b,
      params.n,
      params.mu,
      params.p,
      params.j,
    );
    const {
      values,
    } = await eventListener(luckysevenContract, 'IParameterReceived');
    expect(values.luckySevenNumber).to.equal(luckySeven({ ...params, i: values.i }));
    expect(values.owner).to.equal(owner);
    expect(Number(values.i)).to.be.a('number');
  });
});
