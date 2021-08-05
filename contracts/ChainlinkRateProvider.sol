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

pragma solidity ^0.7.0;

import "@chainlink/contracts/src/v0.7/interfaces/FeedRegistryInterface.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

import "./interfaces/IRateProvider.sol";

/**
 * @title Chainlink Rate Provider
 * @notice Returns a Chainlink price feed's quote for the provided currency pair
 */
contract ChainlinkRateProvider is IRateProvider {
    FeedRegistryInterface public immutable registry;
    address public immutable base;
    address public immutable quote;

    /**
     * @param _registry - The Chainlink price feed registry contract
     * @param _base - The identifier for the currency which the quoted rate will be denominated in
     * @param _quote - The identifier for the currency for which a price will be quoted
     */
    constructor(
        FeedRegistryInterface _registry,
        address _base,
        address _quote
    ) {
        registry = _registry;
        base = _base;
        quote = _quote;
    }

    /**
     * @return the value of the quote currency in terms of the base currency
     */
    function getRate() external view override returns (uint256) {
        (, int256 price, , , ) = registry.latestRoundData(base, quote);
        require(price > 0, "Invalid price rate response");
         
        // Metastable pools expect a response of a fixed-point value with 18 decimals
        // We then need to scale the price feed's output to match this.
        // Price feeds with more than 18 decimals are not supported.
        uint256 scalingFactor = 10 ** SafeMath.sub(18, registry.decimals(base, quote));
        return uint256(price) * scalingFactor;
    }
}
