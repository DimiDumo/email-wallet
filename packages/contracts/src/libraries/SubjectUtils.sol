// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./DecimalUtils.sol";
import "./BytesUtils.sol";
import "../interfaces/Types.sol";
import "../interfaces/Commands.sol";
import "../utils/TokenRegistry.sol";

library SubjectUtils {
    /// @notice Return the token address for a token name.
    /// @param tokenName Name of the token
    function getTokenAddrFromName(string memory tokenName, TokenRegistry tokenRegistry) public view returns (address) {
        if (Strings.equal(tokenName, "ETH")) {
            return tokenRegistry.getTokenAddress("WETH");
        }

        return tokenRegistry.getTokenAddress(tokenName);
    }

    /// @notice Calculate the masked subject for an EmailOp from command and other params
    ///         This also do sanity checks of certain parameters used in the subject
    /// @param emailOp EmailOp from which the masked subject is to be computed
    function computeMaskedSubjectForEmailOp(
        EmailOp memory emailOp,
        address walletAddr,
        TokenRegistry tokenRegistry,
        address extAddr,
        string[][] memory subjectTemplatesOfExtension
    ) public view returns (string memory maskedSubject, bool isExtension) {
        // Sample: Send 1 ETH to recipient@domain.com
        if (Strings.equal(emailOp.command, Commands.SEND)) {
            WalletParams memory walletParams = emailOp.walletParams;
            ERC20 token = ERC20(getTokenAddrFromName(emailOp.walletParams.tokenName, tokenRegistry));

            require(token != ERC20(address(0)), "token not supported");
            require(emailOp.walletParams.amount > 0, "send amount should be >0");
            require(token.balanceOf(walletAddr) >= walletParams.amount, "insufficient balance");

            maskedSubject = string.concat(
                Commands.SEND,
                " ",
                DecimalUtils.uintToDecimalString(walletParams.amount, token.decimals()),
                " ",
                walletParams.tokenName,
                " to "
            );

            if (emailOp.recipientETHAddr != address(0)) {
                maskedSubject = string.concat(
                    maskedSubject,
                    Strings.toHexString(uint256(uint160(emailOp.recipientETHAddr)), 20)
                );
            }
        }
        // Sample: Execute 0x000112aa..
        else if (Strings.equal(emailOp.command, Commands.EXECUTE)) {
            require(emailOp.executeCallData.length > 0, "executeCallData cannot be empty");

            (address target, , bytes memory data) = abi.decode(emailOp.executeCallData, (address, uint256, bytes));

            require(target != address(0), "invalid execute target");
            require(target != address(this), "cannot execute on core");
            require(target != walletAddr, "cannot execute on wallet");
            require(bytes(tokenRegistry.getTokenNameOfAddress(target)).length == 0, "cannot execute on token");
            require(data.length > 0, "execute data cannot be empty");

            maskedSubject = string.concat(
                Commands.EXECUTE,
                " 0x",
                BytesUtils.bytesToHexString(emailOp.executeCallData)
            );
        }
        // Sample: Install extension Uniswap
        else if (Strings.equal(emailOp.command, Commands.INSTALL_EXTENSION)) {
            require(extAddr != address(0), "extension not registered");

            maskedSubject = string.concat(Commands.INSTALL_EXTENSION, " extension ", emailOp.extensionName);
        }
        // Sample: Remove extension Uniswap
        else if (Strings.equal(emailOp.command, Commands.UNINSTALL_EXTENSION)) {
            require(extAddr != address(0), "extension not registered");
            maskedSubject = string.concat(Commands.UNINSTALL_EXTENSION, " extension ", emailOp.extensionName);
        }
        // Sample: Exit email wallet. Change owner to 0x000112aa..
        else if (Strings.equal(emailOp.command, Commands.EXIT_EMAIL_WALLET)) {
            require(emailOp.newWalletOwner != address(0), "newWalletOwner cannot be empty");

            maskedSubject = string.concat(
                Commands.EXIT_EMAIL_WALLET,
                " Email Wallet. Change ownership to ",
                Strings.toHexString(uint256(uint160(emailOp.newWalletOwner)), 20)
            );
        }
        // Sample: DKIM registry as 0x000112aa..
        else if (Strings.equal(emailOp.command, Commands.DKIM)) {
            require(emailOp.newDkimRegistry != address(0), "newDkimRegistry cannot be empty");

            maskedSubject = string.concat(
                Commands.DKIM,
                " registry set to ",
                Strings.toHexString(uint256(uint160(emailOp.newDkimRegistry)), 20)
            );
        }
        // The command is for an extension
        else {
            isExtension = true;
            string[] memory subjectTemplate = subjectTemplatesOfExtension[emailOp.extensionParams.subjectTemplateIndex];

            uint8 nextParamIndex;
            for (uint8 i = 0; i < subjectTemplate.length; i++) {
                string memory matcher = string(subjectTemplate[i]);
                string memory value;

                // {tokenAmount} is combination of tokenName and amount, encoded as (uint256,string). Eg: `30.23 DAI`
                if (Strings.equal(matcher, Commands.TOKEN_AMOUNT_TEMPLATE)) {
                    (uint256 amount, string memory tokenName) = abi.decode(
                        emailOp.extensionParams.subjectParams[nextParamIndex],
                        (uint256, string)
                    );
                    address tokenAddr = getTokenAddrFromName(tokenName, tokenRegistry);

                    require(tokenAddr != address(0), "token not supported");
                    // We are not validating token balance here, as tokenAmount might not be always for debiting from wallet

                    value = string.concat(
                        DecimalUtils.uintToDecimalString(amount, ERC20(tokenAddr).decimals()),
                        " ",
                        tokenName
                    );
                    nextParamIndex++;
                }
                // {amount} is number in wei format (decimal format in subject)
                else if (Strings.equal(matcher, Commands.AMOUNT_TEMPLATE)) {
                    uint256 num = abi.decode(emailOp.extensionParams.subjectParams[nextParamIndex], (uint256));
                    value = DecimalUtils.uintToDecimalString(num);
                    nextParamIndex++;
                }
                // {string} is plain string
                else if (Strings.equal(matcher, Commands.STRING_TEMPLATE)) {
                    value = abi.decode(emailOp.extensionParams.subjectParams[nextParamIndex], (string));
                    nextParamIndex++;
                }
                // {uint} is number parsed the same way as mentioned in subject (decimals not allowed) - use {amount} for decimals
                else if (Strings.equal(matcher, Commands.UINT_TEMPLATE)) {
                    uint256 num = abi.decode(emailOp.extensionParams.subjectParams[nextParamIndex], (uint256));
                    value = Strings.toString(num);
                    nextParamIndex++;
                }
                // {int} for negative values
                else if (Strings.equal(matcher, Commands.INT_TEMPLATE)) {
                    int256 num = abi.decode(emailOp.extensionParams.subjectParams[nextParamIndex], (int256));
                    value = Strings.toString(num);
                    nextParamIndex++;
                }
                // {addres} for wallet address
                else if (Strings.equal(matcher, Commands.ADDRESS_TEMPLATE)) {
                    address addr = abi.decode(emailOp.extensionParams.subjectParams[nextParamIndex], (address));
                    value = Strings.toHexString(uint256(uint160(addr)), 20);
                    nextParamIndex++;
                } else if (Strings.equal(matcher, Commands.RECIPIENT_TEMPLATE)) {
                    if (!emailOp.hasEmailRecipient) {
                        value = Strings.toHexString(uint256(uint160(emailOp.recipientETHAddr)), 20);
                    }
                }
                // Constant string otherwise
                else {
                    value = matcher;
                }

                if (bytes(maskedSubject).length == 0) {
                    maskedSubject = value;
                } else {
                    maskedSubject = string.concat(maskedSubject, " ", value);
                }
            }

            // We should have used all items in subjectParams by now
            require(nextParamIndex == emailOp.extensionParams.subjectParams.length, "invalid subject params length");
        }
    }
}
