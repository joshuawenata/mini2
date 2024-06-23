import Foundation

class Character: Codable, Identifiable {
    var id = UUID()
    var characterLevel: Int = 1
    var characterBaseHP: Int = 100
    var characterBaseAttack: Int = 5
    var characterMoney: Int = 1000
    var EquipedWeapon: WeaponModel = WeaponModel(weaponName: "Sword", weaponDescription: "", weaponPrice: 0, weaponAttack: 10, weaponImage: "", weapomJoystickImage: "")
    var EquipedSkill: SkillModel = SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillDescription: "", skillImage: "", SkillJoystickImage: "")
    var collectedWeapon: [WeaponModel] = [
        WeaponModel(weaponName: "Sword", weaponDescription: "", weaponPrice: 0, weaponAttack: 10, weaponImage: "", weapomJoystickImage: "")
    ]
    var collectedSkill: [SkillModel] = [
        SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillDescription: "", skillImage: "", SkillJoystickImage: "")
    ]
    
    
}
