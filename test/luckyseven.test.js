import { expect } from 'chai';
import luckySeven from './helpers/luckySeven';
import { envParameters, needsGetJobId } from '../environments';
import getChainlinkJobId from './helpers/getChainlinkJobId';
import { eventListener } from './helpers';

const LinkToken = artifacts.require('@openzeppelin/contracts/token/ERC20/IERC20');

const LuckySeven = artifacts.require('LuckySeven');

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
  describe('Insecure requests', () => {
    it('single source without testimonies', async () => {
    // Add link tokens to LuckySeven contract to call Chainlink
      await chainlinkToken.transfer(luckysevenContract.address, web3.utils.toWei('0.1'));
      const params = {
        b: 0,
        n: 20,
        mu: 0,
        p: 50,
        i: 7,
        j: 0,
      };
      luckysevenContract.singleSourceWithoutTestimonies(Object.values(params));
      const {
        values,
      } = await eventListener(luckysevenContract, 'SingleSourceWithoutTestimoniesReceived');
      const { chainlinkParameters } = values;
      const [b, mu, j] = chainlinkParameters.split(',');
      expect(values.luckySevenNumber).to.equal(luckySeven({
        ...params, b, mu, j,
      }));
      expect(values.owner).to.equal(owner);
      expect(Number(values.i)).to.be.a('number');
    });
  });
});
