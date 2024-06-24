//
//  Skill.swift
//  mini2
//
//  Created by Timothy Andrian on 23/06/24.
//

import Foundation

class SkillModel: Codable, Identifiable {
    var id = UUID()
    var skillName: String
    var skillDamage: Int
    var skillCoolDown: Int
    var skillPrice: Int
    var skillImage: String
    var skillJoystickImage: String
    
    init(id: UUID = UUID(), skillName: String, skillDamage: Int, skillCoolDown: Int, skillPrice: Int, skillImage: String, skillJoystickImage: String) {
        self.id = id
        self.skillName = skillName
        self.skillDamage = skillDamage
        self.skillCoolDown = skillCoolDown
        self.skillPrice = skillPrice
        self.skillImage = skillImage
        self.skillJoystickImage = skillJoystickImage
    }
}
