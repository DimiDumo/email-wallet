// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "@zk-email/contracts/DKIMRegistry.sol";
import "../src/EmailWalletCore.sol";
import "../src/utils/TokenRegistry.sol";
import "../src/utils/UniswapTWAPOracle.sol";
import "./mock/TestVerifier.sol";
import "./mock/TestERC20.sol";

contract EmailWalletCoreTestHelper is Test {
    EmailWalletCore core;
    TestVerifier verifier;
    TokenRegistry tokenRegistry;
    DKIMRegistry dkimRegistry;
    IPriceOracle priceOracle;

    TestERC20 wethToken;
    TestERC20 daiToken;
    TestERC20 usdcToken;

    address deployer;
    address relayer;

    bytes mockProof = abi.encodePacked(bytes1(0x01));

    // Relayer details
    uint256 relayerRand = 10001;
    bytes32 randHash = keccak256(abi.encodePacked(relayerRand));

    // User details (sender) - for when sender failure is not expected
    // Computing hashes to resemble the actual process
    string senderEmail = "sender@test.com";
    string emailDomain = "test.com";
    uint256 viewingKey = 2001;
    bytes32 emailAddrPointer = keccak256(abi.encodePacked(relayerRand, senderEmail));
    bytes32 viewingKeyCommitment = keccak256(abi.encodePacked(viewingKey, senderEmail, randHash));
    bytes32 walletSalt = keccak256(abi.encodePacked(viewingKeyCommitment, uint(0)));
    bytes psiPoint = abi.encodePacked(uint(1004));
    address walletAddr;

    function setUp() public virtual {
        deployer = vm.addr(1);
        relayer = vm.addr(2);

        vm.startPrank(deployer);

        verifier = new TestVerifier();
        tokenRegistry = new TokenRegistry();
        dkimRegistry = new DKIMRegistry();
        priceOracle = new UniswapTWAPOracle(address(0), address(0));

        // Deploy core contract as proxy
        address implementation = address(new EmailWalletCore());
        bytes memory data = abi.encodeCall(
            EmailWalletCore.initialize,
            (
                address(verifier),
                address(tokenRegistry),
                address(dkimRegistry),
                address(priceOracle),
                10 ** 10,
                0.0001 ether,
                30 days
            )
        );
        core = EmailWalletCore(address(new ERC1967Proxy(implementation, data)));

        // Set test sender's wallet addr
        walletAddr = core.getWalletOfSalt(walletSalt);

        // Set a mock DKIM public key hash for test sender's emailDomain
        dkimRegistry.setDKIMPublicKeyHash(emailDomain, uint256(111122223333));

        // Deploy some ERC20 test tokens and add them to registry
        wethToken = new TestERC20("WETH", "WETH");
        daiToken = new TestERC20("DAI", "DAI");
        usdcToken = new TestERC20("USDC", "USDC");
        tokenRegistry.setTokenAddress("WETH", address(wethToken));
        tokenRegistry.setTokenAddress("DAI", address(daiToken));
        tokenRegistry.setTokenAddress("USDC", address(usdcToken));

        vm.stopPrank();
    }

    // Register the test relayer - when not testing relayer functionality
    function _registerRelayer() internal {
        vm.startPrank(relayer);
        core.registerRelayer(randHash, "relayer@relayer.xyz", "relayer.xyz");
        vm.stopPrank();
    }

    // Register test user account - for using as sender when not testing accoung functionality
    function _registerAndInitializeAccount() internal {
        vm.startPrank(relayer);
        bytes32 emailNullifier = bytes32(uint(1002130510010012931231923879));
        core.createAccount(emailAddrPointer, viewingKeyCommitment, walletSalt, psiPoint, mockProof);
        core.initializeAccount(emailAddrPointer, emailDomain, emailNullifier, mockProof);
        vm.stopPrank();
    }
}
