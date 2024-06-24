//
//  Weapon.swift
//  mini2
//
//  Created by Timothy Andrian on 23/06/24.
//

import Foundation

class WeaponModel: CollectableItem {
    var weaponName: String
    var weaponPrice: Int
    var weaponAttack: Int
    var weaponImage: String
    
    init(weaponName: String, weaponPrice: Int, weaponAttack: Int, weaponImage: String) {
        self.weaponName = weaponName
        self.weaponPrice = weaponPrice
        self.weaponAttack = weaponAttack
        self.weaponImage = weaponImage
        
        super.init(itemName: weaponName, itemPrice: weaponPrice, itemImage: weaponImage)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
