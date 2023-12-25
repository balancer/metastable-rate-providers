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
import "./interfaces/IAaveV2LendingPool.sol";

/**
 * @title RAI Redemption Price Rate Provider
 * @notice Returns the redemption price of RAI in terms of USD
 */
contract RAIRedemptionRateProvider is IRateProvider {
    address public immutable rai;
    IRedemptionPriceSnap public immutable redemptionPriceSnap;
    IAaveV2LendingPool public immutable aaveV2LendingPool;

    constructor(
        address _rai,
        IRedemptionPriceSnap _redemptionPriceSnap,
        IAaveV2LendingPool _aaveV2LendingPool
    ) {
        rai = _rai;
        redemptionPriceSnap = _redemptionPriceSnap;
        aaveV2LendingPool = _aaveV2LendingPool;
    }

    /**
     * @return The redemption price of RAI in terms of USD
     */
    function getRate() external view override returns (uint256) {
        // snappedRedemptionPrice is RAY, we need to convert it to WAD
        uint256 raiRedemptionPrice = redemptionPriceSnap.snappedRedemptionPrice() / 10**9;

        // Return the RAI aToken USD price as WAD
        return (raiRedemptionPrice * aaveV2LendingPool.getReserveNormalizedIncome(rai)) / 10**27;
    }
}
