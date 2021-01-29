// import { envParameters } from '../../environments';
//
// const Web3 = require('web3');
//
// const contractCreator = (contract) => {
//   const { abi, address } = contract;
//   try {
//     const web3 = new Web3(
//       new Web3.providers.WebsocketProvider(envParameters.web3WebsocketProviderUrl),
//     );
//     return new web3.eth.Contract(abi, address);
//   } catch (error) {
//     console.log(error);
//     throw new Error(error.message);
//   }
// };
//
// // returns the second half of values, since the first half is only the position
// // of the value. e.g. {0:'hola','message':hola}
// const filterEventValues = (values) => {
//   const valuesCount = Object.keys(values).length;
//   const splicedEntries = Object.entries(values).slice(
//     valuesCount / 2,
//     valuesCount,
//   );
//   return splicedEntries.reduce((r, [k, v]) => Object.assign(r, { [k]: v }), {});
// };
//
// // event listener
// const eventListener = async (contract, event) => {
//   const web3Contract = contractCreator(contract);
//   return new Promise((resolve, reject) => {
//     web3Contract.events.allEvents(
//       {
//         fromBlock: 'latest',
//       },
//       // eslint-disable-next-line consistent-return
//       (error, result) => {
//         if (error) {
//           return reject(error);
//         }
//         const { event: name, returnValues: values } = result;
//         const response = { name, values: filterEventValues(values) };
//         if (result.event === event) {
//           return resolve(response);
//         }
//       },
//     );
//     // .on("data", () => (error, result) => {
//     //   if (error) return reject(error);
//     //   return resolve(result);
//     // });
//   });
// };
//
// export default eventListener;
