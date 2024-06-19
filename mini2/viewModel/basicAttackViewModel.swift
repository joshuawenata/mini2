//
//  basicAttackViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 12/06/24.
//

import Foundation
import SpriteKit

func startAttackAnimation(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    let attackCharacterTextures = [SKTexture(imageNamed: "attack_00000"),SKTexture(imageNamed: "attack_00001"),SKTexture(imageNamed: "attack_00002"),SKTexture(imageNamed: "attack_00003"),SKTexture(imageNamed: "attack_00004"),SKTexture(imageNamed: "attack_00005"),SKTexture(imageNamed: "attack_00006"),SKTexture(imageNamed: "attack_00007"),SKTexture(imageNamed: "attack_00008"),SKTexture(imageNamed: "attack_00009"),SKTexture(imageNamed: "attack_00010"),SKTexture(imageNamed: "attack_00011"),SKTexture(imageNamed: "attack_00012"),SKTexture(imageNamed: "attack_00013"),SKTexture(imageNamed: "attack_00014")]
    let attackCharacterAnimation = SKAction.animate(with: attackCharacterTextures, timePerFrame: 0.02, resize: false, restore: true)
    let repeatAttackCharacter = SKAction.repeat(attackCharacterAnimation, count: 1)
    characterNode.run(repeatAttackCharacter, withKey: "attack")
}

func startSlashAnimation(slashNode: SKSpriteNode?) {
    guard let slashNode = slashNode else { return }
    
    let slashTextures = [SKTexture(imageNamed: "slash_00000"),SKTexture(imageNamed: "slash_00001"),SKTexture(imageNamed: "slash_00002"),SKTexture(imageNamed: "slash_00003"),SKTexture(imageNamed: "slash_00004"),SKTexture(imageNamed: "slash_00005"),SKTexture(imageNamed: "slash_00006"),SKTexture(imageNamed: "slash_00007"),SKTexture(imageNamed: "slash_00008"),SKTexture(imageNamed: "slash_00009"),SKTexture(imageNamed: "slash_00010"),SKTexture(imageNamed: "slash_00011"),SKTexture(imageNamed: "slash_00012"),SKTexture(imageNamed: "slash_00013"),SKTexture(imageNamed: "slash_00014")]
    let slashAnimation = SKAction.animate(with: slashTextures, timePerFrame: 0.02, resize: false, restore: true)
    let repeatSlash = SKAction.repeat(slashAnimation, count: 1)
    slashNode.run(repeatSlash, withKey: "slash")
}

func startAttackAnimationBattle(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    let attackCharacterTextures = [SKTexture(imageNamed: "attack2_00000"),SKTexture(imageNamed: "attack2_00001"),SKTexture(imageNamed: "attack2_00002"),SKTexture(imageNamed: "attack2_00003"),SKTexture(imageNamed: "attack2_00004"),SKTexture(imageNamed: "attack2_00005"),SKTexture(imageNamed: "attack2_00006"),SKTexture(imageNamed: "attack2_00007"),SKTexture(imageNamed: "attack2_00008"),SKTexture(imageNamed: "attack2_00009"),SKTexture(imageNamed: "attack2_00010"),SKTexture(imageNamed: "attack2_00011"),SKTexture(imageNamed: "attack2_00012"),SKTexture(imageNamed: "attack2_00013"),SKTexture(imageNamed: "attack2_00014")]
    let attackCharacterAnimation = SKAction.animate(with: attackCharacterTextures, timePerFrame: 0.02, resize: false, restore: true)
    let repeatAttackCharacter = SKAction.repeat(attackCharacterAnimation, count: 1)
    characterNode.run(repeatAttackCharacter, withKey: "attack")
}
