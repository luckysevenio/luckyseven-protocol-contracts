// solhint-disable-line
pragma solidity ^0.6.0;

contract ParseUtils {
    // @dev returns a comma separated value
    function _parseCSV(
        string memory _commaSeparatedValue,
        uint256 _requestedParameters
    ) internal pure returns (uint256[] memory) {
        bytes memory bytesCSV = bytes(_commaSeparatedValue);
        uint256[] memory parameters = new uint256[](_requestedParameters);
        bytes memory parameter = '';
        uint256 parameterCounter = 0;
        for (uint256 index; index < bytesCSV.length; index++) {
            if (bytesCSV[index] == bytes1(',')) {
                parameters[parameterCounter] = _bytesToUint(parameter);
                parameter = '';
                parameterCounter += 1;
            } else {
                parameter = abi.encodePacked(parameter, bytesCSV[index]);
            }
        }
        parameters[parameterCounter] = _bytesToUint(parameter);
        return parameters;
    }

    function _fillParameters(
        uint256[] memory _userParameters,
        uint256[] memory _chainlinkParameters
    ) internal pure returns (uint256[] memory) {
        uint256[] memory parameters = new uint256[](_userParameters.length);
        uint256 parameterCounter = 0;
        for (uint256 index = 0; index < _userParameters.length; index++) {
            if (_userParameters[index] == 0) {
                parameters[index] = _chainlinkParameters[parameterCounter];
                parameterCounter += 1;
            } else {
                parameters[index] = _userParameters[index];
            }
        }
        return parameters;
    }

    function _addressToString(address _address)
        internal
        pure
        returns (string memory)
    {
        bytes32 _bytes = bytes32(uint256(_address));
        bytes memory HEX = '0123456789abcdef';
        bytes memory _string = new bytes(42);
        _string[0] = '0';
        _string[1] = 'x';
        for (uint256 i = 0; i < 20; i++) {
            _string[2 + i * 2] = HEX[uint8(_bytes[i + 12] >> 4)];
            _string[3 + i * 2] = HEX[uint8(_bytes[i + 12] & 0x0f)];
        }
        return string(_string);
    }

    function _bytes32ToStr(bytes32 _bytes32)
        internal
        pure
        returns (string memory)
    {
        uint8 i = 0;
        while (i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }

    function _bytes32ToUint(bytes32 _b) internal pure returns (uint256 result) {
        result = 0;
        bytes memory b = abi.encodePacked(_b);
        for (uint256 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
        return result;
    }

    function _bytesToUint(bytes memory b)
        internal
        pure
        returns (uint256 result)
    {
        result = 0;
        for (uint256 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
        return result;
    }

    /*
        ORACLIZE_API
        Copyright (c) 2015-2016 Oraclize SRL
        Copyright (c) 2016 Oraclize LTD
        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
        The above copyright notice and this permission notice shall be included in
        all copies or substantial portions of the Software.
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
        THE SOFTWARE.
    */
    function _uintToStr(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        uint256 number = _i;
        if (number == 0) {
            return '0';
        }
        uint256 j = number;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len - 1;
        while (number != 0) {
            bstr[k--] = bytes1(uint8(48 + (number % 10)));
            number /= 10;
        }
        return string(bstr);
    }
}
