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
