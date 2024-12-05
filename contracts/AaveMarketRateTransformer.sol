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

import "./ERC4626RateProviderBase.sol";

import "./interfaces/IRateProvider.sol";
import "@openzeppelin/contracts/interfaces/IERC4626.sol";

contract AaveMarketRateTransformer is ERC4626RateProviderBase {
    address public vaultAssetFeed;

    constructor(address _vaultAssetFeed, address _erc4626Vault) 
    ERC4626RateProviderBase(IERC4626(_erc4626Vault))
    {
        vaultAssetFeed = _vaultAssetFeed;
    }

    function getRate() public view override returns (uint256) {
        // super.getRate returns an 18 decimal fixed point number
        return (super.getRate() * IRateProvider(vaultAssetFeed).getRate()) / 1e18;
    }
}