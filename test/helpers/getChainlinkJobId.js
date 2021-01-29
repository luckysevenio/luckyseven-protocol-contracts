// import axios from 'axios';
// import { envParameters } from '../../environments';
//
// const baseURL = envParameters.chainlinkNodeUrl;
//
// const getSessionCookie = async () => {
//   const resp = await axios({
//     method: 'post',
//     url: `${baseURL}/sessions`,
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     data: {
//       email: 'test@stacktical.com',
//       password: 'password',
//     },
//   });
//   return resp.headers['set-cookie'];
// };
//
// const getChainlinkJobId = async () => {
//   const sessionCookie = await getSessionCookie();
//   const { data } = await axios({
//     method: 'get',
//     url: `${baseURL}/v2/specs`,
//     headers: {
//       Cookie: sessionCookie,
//       'Content-Type': 'application/json',
//     },
//     withCredentials: true,
//   });
//   return `0x${data.data[0].id}`;
// };
//
// export default getChainlinkJobId;
