//
//  Weapon.swift
//  mini2
//
//  Created by Timothy Andrian on 23/06/24.
//

import Foundation

class WeaponModel: Identifiable, Codable {
    var id = UUID()
    var weaponName: String
    var weaponPrice: Int
    var weaponAttack: Int
    var weaponImage: String
    
    init(id: UUID = UUID(), weaponName: String, weaponPrice: Int, weaponAttack: Int, weaponImage: String) {
        self.id = id
        self.weaponName = weaponName
        self.weaponPrice = weaponPrice
        self.weaponAttack = weaponAttack
        self.weaponImage = weaponImage
    }
}
