// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ✅ Import each Verifier with unique contract names
import "./AgeCheckVerifier.sol";
import "./CountryCheckVerifier.sol";
import "./RangeProofVerifier.sol";

contract KYCManager {
    // External verifier contract instances
    AgeCheckVerifier public ageVerifier;
    CountryCheckVerifier public countryVerifier;
    RangeProofVerifier public rangeVerifier;

    // Mapping wallet address to KYC level
    mapping(address => uint8) public kycLevels;

    // Events
    event KYCLevelUpdated(address indexed user, uint8 level);
    event ProofVerified(address indexed user, string checkType);

    constructor(
        address _ageVerifier,
        address _countryVerifier,
        address _rangeVerifier
    ) {
        ageVerifier = AgeCheckVerifier(_ageVerifier);
        countryVerifier = CountryCheckVerifier(_countryVerifier);
        rangeVerifier = RangeProofVerifier(_rangeVerifier);
    }

    // ✅ Verify Age Proof (e.g., Age > 18)
    function verifyAgeProof(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[] memory input
    ) public returns (bool) {
        require(input.length == 1, "Invalid input length for Age Proof");

        uint256[1] memory inputArr;
        inputArr[0] = input[0];

        bool success = ageVerifier.verifyProof(a, b, c, inputArr);
        require(success, "Invalid Age Proof");

        emit ProofVerified(msg.sender, "Age");
        return true;
    }

    // ✅ Verify Country Proof (e.g., Nationality == India)
    function verifyCountryProof(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[] memory input
    ) public returns (bool) {
        require(input.length == 1, "Invalid input length for Country Proof");

        uint256[1] memory inputArr;
        inputArr[0] = input[0];

        bool success = countryVerifier.verifyProof(a, b, c, inputArr);
        require(success, "Invalid Country Proof");

        emit ProofVerified(msg.sender, "Country");
        return true;
    }

    // ✅ Verify Range Proof (e.g., Age between 18-25)
    function verifyRangeProof(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[] memory input
    ) public returns (bool) {
        require(input.length == 1, "Invalid input length for Range Proof");

        uint256[1] memory inputArr;
        inputArr[0] = input[0];

        bool success = rangeVerifier.verifyProof(a, b, c, inputArr);
        require(success, "Invalid Range Proof");

        emit ProofVerified(msg.sender, "Range");
        return true;
    }

    // ✅ Set KYC Level Onchain (Once all verifications are done)
    function setKYCLevel(address user, uint8 level) public {
        require(level >= 1 && level <= 3, "Invalid KYC Level");

        kycLevels[user] = level;
        emit KYCLevelUpdated(user, level);
    }

    // Optional: Get current KYC level
    function getKYCLevel(address user) external view returns (uint8) {
        return kycLevels[user];
    }
}
