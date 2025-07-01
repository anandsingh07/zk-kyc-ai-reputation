// SPDX-License-Identifier: GPL-3.0
/*
    Generated with snarkJS.
    License: GPL v3.0
*/

pragma solidity >=0.7.0 <0.9.0;

contract CountryCheckVerifier {
    uint256 constant r    = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    uint256 constant q    = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    uint256 constant alphax  = 12481697430309723639374463553699833232442546793093528472743559890483300780271;
    uint256 constant alphay  = 8314330919124771903414998983721903041965987589400931926079681632308736428914;
    uint256 constant betax1  = 10174567231632721014692806524753019154719376372724606685521465778403603813484;
    uint256 constant betax2  = 3811111928326298881545174280435405749955155589012842109018181064838842442243;
    uint256 constant betay1  = 5158963265108827426106087258627113396799351799759580495767937058480886647885;
    uint256 constant betay2  = 13547644333648221775570326650155104161909763247795137849682974368886228087739;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 6554851908929843573115968542176631047337665262794582429466680258514249060710;
    uint256 constant deltax2 = 15213555979541453223693812972431578581827725962974269793727191412144136419927;
    uint256 constant deltay1 = 2969634696573475290141133650946363864959671529096661989972903432938321861413;
    uint256 constant deltay2 = 7403522987619919334617368633248239103111571875630074968579217148319621409510;

    uint256 constant IC0x = 2794628540462751883661725287673575475272752553024939725623036075258790407919;
    uint256 constant IC0y = 18729591692833909686106568956668333937645059262372585506532318913810509630886;
    uint256 constant IC1x = 21722651009124579861541337079908683382087449106392661131758269415253737746394;
    uint256 constant IC1y = 4738297800363248541248237197108525336484198356570339570655563896585920881014;

    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;
    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[1] calldata _pubSignals) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, r)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)
                if iszero(success) { mstore(0, 0) return(0, 0x20) }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)
                if iszero(success) { mstore(0, 0) return(0, 0x20) }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))

                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))

                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)

                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)
                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            checkField(calldataload(add(_pubSignals, 0)))

            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
            return(0, 0x20)
        }
    }
}
