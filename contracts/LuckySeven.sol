//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import '@chainlink/contracts/v0.6/ChainlinkClient.sol';
import './LuckySevenPRNG.sol';
import './ParseUtils.sol';

/**
 * @title LuckySeven
 * @dev LuckySeven is a contract to generate random number with low cost
 */
contract LuckySeven is ChainlinkClient, LuckySevenPRNG, ParseUtils {
    enum JobCodes {singleSourceWithoutTestimonies}

    struct LuckySevenNumber {
        uint256 b;
        uint256 n;
        uint256 mu;
        uint256 p;
        uint256 i;
        uint256 j;
        uint256 number;
        address owner;
    }

    struct JobRequestWithoutTestimonies {
        string jobType;
        uint256[] userParams;
        uint256 requestedParameters;
        address owner;
    }

    bytes32[] public requests;
    mapping(bytes32 => JobRequestWithoutTestimonies)
        public requestToJobRequestWithoutTestimonies;
    mapping(address => LuckySevenNumber[]) public luckySevenNumbersRegister;

    // @dev Chainlink oracle address
    address public chainlinkOracle;
    // @dev chainlink jobId
    bytes32 public chainlinkJobId;
    // @dev fee for Chainlink querys. Currently 0.1 LINK
    uint256 public fee = 0.1 * 10**18;

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
     * @param _userParameters 1. array of parameters sent by the user. 0s are considered requests
     */

    function singleSourceWithoutTestimonies(uint256[] memory _userParameters)
        public
    {
        Chainlink.Request memory request =
            buildChainlinkRequest(
                chainlinkJobId,
                address(this),
                this.fulFillSingleSourceWithoutTestimonies.selector
            );
        string memory query = '';
        uint256 requestedParameters = 0;
        for (uint256 index = 0; index < _userParameters.length; index++) {
            if (_userParameters[index] == 0) {
                query = string(abi.encodePacked(query, _uintToStr(index)));
                requestedParameters += 1;
            }
        }
        request.add('job_type', 'single_source_without_testimonies');
        request.add('job_data', query);
        bytes32 requestId =
            sendChainlinkRequestTo(chainlinkOracle, request, fee);
        requests.push(requestId);
        requestToJobRequestWithoutTestimonies[
            requestId
        ] = JobRequestWithoutTestimonies({
            jobType: 'single_source_without_testimonies',
            userParams: _userParameters,
            requestedParameters: requestedParameters,
            owner: msg.sender
        });
    }

    /**
     * @dev event triggered when a I parameter is received from Chainlink for the PRNG
     * @param chainlinkParameters 1. comma separated value returned by Chainlink
     * @param luckySevenNumber 2. LuckySevenNumber, calculated using the Chainlink parameteres and the PRNG
     * @param owner 3. owner of the LuckySevenNumber
     */
    event SingleSourceWithoutTestimoniesReceived(
        string chainlinkParameters,
        uint256 luckySevenNumber,
        address indexed owner
    );

    /**
     * @dev callback function for the Chainlink SLI request which stores
     * the SLI in the SLA contract
     * @param _requestId the ID of the ChainLink request
     * @param _chainlinkResponse response uint256 from Chainlink Node
     */
    function fulFillSingleSourceWithoutTestimonies(
        bytes32 _requestId,
        bytes32 _chainlinkResponse
    ) public recordChainlinkFulfillment(_requestId) {
        JobRequestWithoutTestimonies memory jobRequest =
            requestToJobRequestWithoutTestimonies[_requestId];
        uint256[] memory chainlinkParameters =
            _parseCSV(
                _bytes32ToStr(_chainlinkResponse),
                jobRequest.requestedParameters
            );
        uint256[] memory parameters =
            _fillParameters(jobRequest.userParams, chainlinkParameters);
        uint256 number =
            prng(
                parameters[0],
                parameters[1],
                parameters[2],
                parameters[3],
                parameters[4],
                parameters[5]
            );
        emit SingleSourceWithoutTestimoniesReceived(
            _bytes32ToStr(_chainlinkResponse),
            number,
            jobRequest.owner
        );
        LuckySevenNumber memory luckySevenNumber =
            LuckySevenNumber({
                number: number,
                b: parameters[0],
                n: parameters[1],
                mu: parameters[2],
                p: parameters[3],
                i: parameters[4],
                j: parameters[5],
                owner: jobRequest.owner
            });
        luckySevenNumbersRegister[luckySevenNumber.owner].push(
            luckySevenNumber
        );
    }
}
