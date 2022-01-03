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

import "./interfaces/IRateProvider.sol";
import "./interfaces/IRedemptionPriceSnap.sol";

/**
 * @title RAI Redemption Price Rate Provider
 * @notice Returns the redemption price of RAI in terms of USD
 */
contract RAIRedemptionRateProvider is IRateProvider {
    IRedemptionPriceSnap public immutable redemptionPriceSnap;

    constructor(IRedemptionPriceSnap _redemptionPriceSnap) {
        redemptionPriceSnap = _redemptionPriceSnap;
    }

    /**
     * @return The redemption price of RAI in terms of USD
     */
    function getRate() external view override returns (uint256) {
        // getRate returns a 18 decimal fixed point number, but `snappedRedemptionPrice` has 27 decimals 
        // (i.e. a 'ray' value) so we need to convert it.
        return redemptionPriceSnap.snappedRedemptionPrice() / 10**9;
    }
}
