//
//  Skill.swift
//  mini2
//
//  Created by Timothy Andrian on 23/06/24.
//

import Foundation

class SkillModel: CollectableItem {
    var skillName: String
    var skillDamage: Int
    var skillCoolDown: Int
    var skillPrice: Int
    var skillImage: String
    
    init(skillName: String, skillDamage: Int, skillCoolDown: Int, skillPrice: Int, skillImage: String) {
        self.skillName = skillName
        self.skillDamage = skillDamage
        self.skillCoolDown = skillCoolDown
        self.skillPrice = skillPrice
        self.skillImage = skillImage
        
        super.init(itemName: skillName, itemPrice: skillPrice, itemImage: skillImage)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
