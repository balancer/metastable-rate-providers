// SPDX-License-Identifier: GPL-3.0-or-later
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.8.0;

import "./interfaces/IBaseRateProviderFactory.sol";

/**
 * @title Chainlink Rate Provider Factory
 * @notice Factory for creating ChainlinkRateProviders
 * @dev This contract is used to create ChainlinkRateProvider contracts.
 *      RateProviders created by this factory are to be used in environments
 *      where the Chainlink registry is not available.
 */
contract BaseRateProviderFactory is IBaseRateProviderFactory {
    // Mapping of rate providers created by this factory.
    mapping(address => bool) internal _factoryCreatedRateProviders;
    bool private _disabled;

    event RateProviderCreated(address indexed rateProvider);
    event FactoryDisabled();

    constructor(address authorizer) {
        // solhint-disable-previous-line no-empty-blocks
    }

    function isRateProviderFromFactory(address rateProvider) external view returns (bool) {
        return _factoryCreatedRateProviders[rateProvider];
    }

    function isDisabled() public view override returns (bool) {
        return _disabled;
    }

    function disable() external override {
        _ensureEnabled();

        _disabled = true;

        emit FactoryDisabled();
    }

    function _ensureEnabled() internal view {
        require(!isDisabled(), "Factory disabled");
    }
}
