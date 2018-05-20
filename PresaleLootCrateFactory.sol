pragma solidity ^0.4.23;

/**
 * @title Ethersparks Presale Loot Crate Factory
 * This contract defines a loot crate and is in charge of creating the loot crates during presale.
 */
 contract PresaleLootCrateFactory {
     uint dnaDigits = 16; // should allow for sufficient variability during the presale creation of lootboxes
     uint dnaMod = 10 ** dnaDigits;
     
     uint uniqueIdCounter = 0; // used during generation of loot crate
     
     struct LootCrate {
         uint dna;
     }
     
    LootCrate[] public lootCrates;
    
    function generateLootCrateDna(bool _isReferralLootCrate) private view returns (uint) {
        /**
         * This function generates a loot crate dna based on:
         * - sender's address
         * - uniqueIdCounter
         * Since the meaning of the crate's dna won't be defined until after the presale,
         * it is ok (and safe) to generate them from those inputs.
         * A referral loot crate has its least significant bit toggled.
         */
         uint rand = uint(keccak256(abi.encodePacked(uint(msg.sender) + uniqueIdCounter)));
         uint dna = rand % dnaMod;
         if (_isReferralLootCrate)
            dna = dna | 0x01;
        else
            dna = dna & 0x00;
         return dna;
    }
    
    function createLootCrate(bool _isReferralLootCrate) private {
         /**
         * If _isReferralLootCrate is true, a referral typed loot crate will be created.
         * uniqueIdCounter is incremented to ensure unique loot crates are generated.
         */
         uint dna = generateLootCrateDna(_isReferralLootCrate);
         lootCrates.push(LootCrate(dna));
         uniqueIdCounter++;
    }
    
    
    
     
 }