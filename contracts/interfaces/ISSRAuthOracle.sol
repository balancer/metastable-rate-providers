// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity >=0.8.0;

interface ISSRAuthOracle {
    function DATA_PROVIDER_ROLE() external view returns (bytes32);

    function DEFAULT_ADMIN_ROLE() external view returns (bytes32);

    function getAPR() external view returns (uint256);

    function getChi() external view returns (uint256);

    function getConversionRate(uint256 timestamp) external view returns (uint256);

    function getConversionRate() external view returns (uint256);

    function getConversionRateBinomialApprox(uint256 timestamp) external view returns (uint256);

    function getConversionRateBinomialApprox() external view returns (uint256);

    function getConversionRateLinearApprox(uint256 timestamp) external view returns (uint256);

    function getConversionRateLinearApprox() external view returns (uint256);

    function getRho() external view returns (uint256);

    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    function getSSR() external view returns (uint256);

    function getSUSDSData() external view returns (SUSDSData memory);

    function grantRole(bytes32 role, address account) external;

    function hasRole(bytes32 role, address account) external view returns (bool);

    function maxSSR() external view returns (uint256);

    function renounceRole(bytes32 role, address callerConfirmation) external;

    function revokeRole(bytes32 role, address account) external;

    function setMaxSSR(uint256 _maxSSR) external;

    function setSUSDSData(SUSDSData memory nextData) external;

    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

struct SUSDSData {
    uint96 ssr; // Sky Savings Rate in per-second value [ray]
    uint120 chi; // Last computed conversion rate [ray]
    uint40 rho; // Last computed timestamp [seconds]
}
