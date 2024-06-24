import Foundation

class Character: Codable, Identifiable, ObservableObject {
    var id = UUID()
    var characterLevel: Int = 1
    var characterBaseHP: Int = 100
    var characterBaseAttack: Int = 5
    var characterMoney: Int = 1000
    var EquipedWeapon: WeaponModel = WeaponModel(weaponName: "Sword", weaponPrice: 0, weaponAttack: 10, weaponImage: "")
    var EquipedSkill: SkillModel = SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillImage: "")
    var collectedWeapon: [WeaponModel] = [
        WeaponModel(weaponName: "Sword", weaponPrice: 0, weaponAttack: 10, weaponImage: "sword 1"),
        WeaponModel(weaponName: "Sword", weaponPrice: 0, weaponAttack: 10, weaponImage: "sword 1"),
        WeaponModel(weaponName: "Sword", weaponPrice: 0, weaponAttack: 10, weaponImage: "sword 1"),
        WeaponModel(weaponName: "Sword", weaponPrice: 0, weaponAttack: 10, weaponImage: "sword 1"),
    ]
    var collectedSkill: [SkillModel] = [
        SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillImage: "fireball"),
        SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillImage: "fireball"),
        SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillImage: "fireball"),
        SkillModel(skillName: "Fireball", skillDamage: 15, skillCoolDown: 5, skillPrice: 0, skillImage: "fireball"),
    ]
}
