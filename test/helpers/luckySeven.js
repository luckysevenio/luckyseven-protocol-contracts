import BigNumber from 'bignumber.js';

const luckySeven = (parameters) => {
  const mu = BigNumber(parameters.mu);
  const i = BigNumber(parameters.i);
  const b = BigNumber(parameters.b);
  const n = BigNumber(parameters.n);
  const p = BigNumber(parameters.p);
  const j = BigNumber(parameters.j);
  const ten = BigNumber(10);
  const tenPowerN = ten.exponentiatedBy(n);
  const tenPowerP = ten.exponentiatedBy(p);
  const M = tenPowerN.minus(mu);
  const P = b.multipliedBy(tenPowerP).dividedBy(M).precision(10000);
  const tenPowerIJ = ten.exponentiatedBy(i.plus(j));
  const tenPowerI = ten.exponentiatedBy(i);
  const numerator1 = P.modulo(tenPowerIJ);
  const numerator2 = P.modulo(tenPowerI);
  const numeratorTotal = numerator1.minus(numerator2);
  const R = numeratorTotal.dividedBy(tenPowerI);
  return R.toString();
};
export default luckySeven;
