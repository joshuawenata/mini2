//
//  Weapon.swift
//  mini2
//
//  Created by Timothy Andrian on 23/06/24.
//

import Foundation

class WeaponModel: CollectableItem {
    var weaponName: String
    var weaponDescription: String
    var weaponPrice: Int
    var weaponAttack: Int
    var weaponImage: String
    var weapomJoystickImage: String
    
    init(weaponName: String, weaponDescription: String, weaponPrice: Int, weaponAttack: Int, weaponImage: String, weapomJoystickImage: String) {
        self.weaponName = weaponName
        self.weaponDescription = weaponDescription
        self.weaponPrice = weaponPrice
        self.weaponAttack = weaponAttack
        self.weaponImage = weaponImage
        self.weapomJoystickImage = weapomJoystickImage
        
        super.init(itemName: weaponName, itemPrice: weaponPrice, itemDescription: weaponDescription, itemImage: weaponImage, itemJoystickImage: weapomJoystickImage)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    
}
