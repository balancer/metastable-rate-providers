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
import "./AaveMarketRateTransformer.sol";

/**
 * @title  Aave Market Rate Transformer Factory
 * @notice This contract is a factory for creating instances of AaveMarketRateTransformer.
 * @dev    This factory contract allows for the deployment of AaveMarketRateTransformer contracts, 
 *         which are used to transform market rates from the Aave protocol.
 */


contract AaveMarketRateTransformerFactory is BaseRateProviderFactory {
    /**
     * @notice Deploys a new AaveMarketRateTransformer contract using a price feed.
     * @param _vaultAssetFeed - The Aave price feed contract.
     * @param _erc4626Vault - The ERC4626 vault contract.
     */
    function create(address _vaultAssetFeed, address _erc4626Vault) external returns (AaveMarketRateTransformer) {
        AaveMarketRateTransformer rateProvider = new AaveMarketRateTransformer(_vaultAssetFeed, _erc4626Vault);
        _onCreate(address(rateProvider));
        return rateProvider;
    }
}