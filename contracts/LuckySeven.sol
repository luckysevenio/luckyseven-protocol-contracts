//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "@chainlink/contracts/v0.6/ChainlinkClient.sol";
import "./LuckySevenPRNG.sol";
import "./ParseUtils.sol";

/**
 * @title LuckySeven
 * @dev LuckySeven is a contract to generate random number with low cost
 */
contract LuckySeven is ChainlinkClient, LuckySevenPRNG, ParseUtils {
    struct LuckySevenNumber {
        uint256 b;
        uint256 n;
        uint256 mu;
        uint256 p;
        uint256 i;
        uint256 j;
        uint256 number;
        bool fulfilled;
        address owner;
    }

    bytes32[] public requests;
    mapping(bytes32 => LuckySevenNumber) public requestToLuckySevenNumber;
    mapping(address => LuckySevenNumber[]) public luckySevenNumbersRegister;

    // @dev Chainlink oracle address
    address public chainlinkOracle;
    // @dev chainlink jobId
    bytes32 public chainlinkJobId;
    // @dev fee for Chainlink querys. Currently 0.1 LINK
    uint256 public fee = 0.1 * 10**18;

    /**
     * @dev event triggered when a I parameter is received from Chainlink for the PRNG
     * @param i 1.value received from Chainlink
     * @param luckySevenNumber 2. LuckySevenNumber, calculated using i and the PRNG
     * @param owner 3. owner of the LuckySevenNumber
     */
    event IParameterReceived(
        uint256 i,
        uint256 luckySevenNumber,
        address indexed owner
    );

    /**
     * @dev parameterize the variables according to network
     * @notice sets the Chainlink parameters (oracle address, token address, jobId) and sets the SLARegistry to 0x0 address
     * @param _chainlinkOracle the address of the oracle to create requests to
     * @param _chainlinkToken the address of LINK token contract
     * @param _chainlinkJobId the job id for the HTTPGet job
     */
    constructor(
        address _chainlinkOracle,
        address _chainlinkToken,
        bytes32 _chainlinkJobId
    ) public {
        setChainlinkToken(_chainlinkToken);
        chainlinkJobId = _chainlinkJobId;
        chainlinkOracle = _chainlinkOracle;
    }

    /**
     * @dev Request a random number without using testimonies
     * @param _b 1. b parameter
     * @param _n 2. n parameter
     * @param _mu 3. mu parameter for the generator
     * @param _p 4. power of the 10 on the base
     * @param _j 5. length of the number
     */

    function requestInsecureIParameter(
        uint256 _b,
        uint256 _n,
        uint256 _mu,
        uint256 _p,
        uint256 _j
    ) public {
        Chainlink.Request memory request =
            buildChainlinkRequest(
                chainlinkJobId,
                address(this),
                this.fulFillInsecureIParameter.selector
            );
        request.add("job_type", "request_insecure_parameter");
        bytes32 requestId =
            sendChainlinkRequestTo(chainlinkOracle, request, fee);
        requests.push(requestId);
        requestToLuckySevenNumber[requestId] = LuckySevenNumber(
            _b,
            _n,
            _mu,
            _p,
            0,
            _j,
            0,
            false,
            msg.sender
        );
    }

    /**
     * @dev callback function for the Chainlink SLI request which stores
     * the SLI in the SLA contract
     * @param _requestId the ID of the ChainLink request
     * @param _chainlinkResponse response uint256 from Chainlink Node
     */
    function fulFillInsecureIParameter(
        bytes32 _requestId,
        bytes32 _chainlinkResponse
    ) public recordChainlinkFulfillment(_requestId) {
        uint256 i = _bytes32ToUint(_chainlinkResponse);
        LuckySevenNumber memory luckySevenNumber =
            requestToLuckySevenNumber[_requestId];
        uint256 number =
            prng(
                luckySevenNumber.b,
                luckySevenNumber.n,
                luckySevenNumber.mu,
                luckySevenNumber.p,
                i,
                luckySevenNumber.j
            );
        emit IParameterReceived(i, number, luckySevenNumber.owner);
        luckySevenNumber.number = number;
        luckySevenNumber.i = i;
        luckySevenNumber.fulfilled = true;
        luckySevenNumbersRegister[luckySevenNumber.owner].push(
            luckySevenNumber
        );
    }
}
