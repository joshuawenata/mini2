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
    var skillDescription: String
    var skillImage: String
    var SkillJoystickImage: String
    
    init(skillName: String, skillDamage: Int, skillCoolDown: Int, skillPrice: Int, skillDescription: String, skillImage: String, SkillJoystickImage: String) {
        self.skillName = skillName
        self.skillDamage = skillDamage
        self.skillCoolDown = skillCoolDown
        self.skillPrice = skillPrice
        self.skillDescription = skillDescription
        self.skillImage = skillImage
        self.SkillJoystickImage = SkillJoystickImage
        
        super.init(itemName: skillName, itemPrice: skillPrice, itemDescription: skillDescription, itemImage: skillImage, itemJoystickImage: SkillJoystickImage)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
