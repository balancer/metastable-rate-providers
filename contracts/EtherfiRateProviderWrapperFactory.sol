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

import "./BaseRateProviderFactory.sol";

import "./EtherfiRateProviderWrapper.sol";

/**
 * @title Etherfi Rate Provider Wrapper Factory
 * @notice Factory for creating EtherfiRateProviderWrappers
 * @dev This contract is used to create EtherfiRateProviderWrapper contracts which wraps the
 * `getRateSafe` call into a `getRate` call.
 */

contract EtherfiRateProviderWrapperFactory is BaseRateProviderFactory {
    /**
     * @notice Deploys a new EtherfiRateProviderWrapper contract using an EtherfiRateProvider contract.
     * @param rateProvider - The EtherfiRateProvider contract.
     */
    function create(IEtherfiRateProvider rateProvider) external returns (EtherfiRateProviderWrapper) {
        EtherfiRateProviderWrapper rateProviderWrapper = new EtherfiRateProviderWrapper(rateProvider);
        _onCreate(address(rateProviderWrapper));
        return rateProviderWrapper;
    }
}
