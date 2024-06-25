import Foundation

class Character: Codable, Identifiable, ObservableObject {
    
    var id = UUID()
    var characterLevel: Int = 1
    var characterBaseHP: Int = 100
    var characterBaseAttack: Int = 5
    var characterMoney: Int = 1000
    var isFirstLogin: Bool = true
    
    var EquipedWeapon: WeaponModel = WeaponModel(weaponName: "Poison Sword", weaponPrice: 0, weaponAttack: 10, weaponImage: "poisonSword",weaponJoystickImage: "poisonSword_joystick")
    var EquipedSkill: SkillModel = SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillImage: "fireball",skillJoystickImage: "fireballIcon")
    var collectedWeapon: [WeaponModel] = [
        WeaponModel(weaponName: "Poison Sword", weaponPrice: 0, weaponAttack: 10, weaponImage: "poisonSword",weaponJoystickImage: "poisonSword_joystick"),
    ]
    var collectedSkill: [SkillModel] = [
        SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillImage: "fireball",skillJoystickImage: "fireballIcon"),
    ]
    
    func getTotalItem() -> Int{
        return collectedSkill.count + collectedWeapon.count
    }
    func getCollectedWeapons() -> [WeaponModel]{
        return collectedWeapon
    }
    func getCollectedSkills() -> [SkillModel]{
        return collectedSkill
    }
    
}
