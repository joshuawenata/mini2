//
//  CharacterViewModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 21/06/24.
//

import Foundation
import SpriteKit

func addCharacterPlayer(_ position: CGPoint) -> SKSpriteNode! {
    guard let characterImage = UIImage(named: "charaIdle") else {
        return nil
    }
    
    let texture = SKTexture(image: characterImage)
    let character = SKSpriteNode(texture: texture)
    character.physicsBody = SKPhysicsBody(texture: texture, size: character.size)
    character.physicsBody?.affectedByGravity = false
    character.position = position
    character.physicsBody?.allowsRotation = false
    character.setScale(0.3)
    character.physicsBody?.categoryBitMask = CollisionCategory.building.rawValue
    character.physicsBody?.collisionBitMask = CollisionCategory.building.rawValue
    character.physicsBody?.contactTestBitMask = CollisionCategory.building.rawValue
    character.physicsBody?.isDynamic = true
    
    return character
}

func startGhostAnimation(ghostNode: SKSpriteNode?) {
    guard let ghostNode = ghostNode else { return }
    
    let ghostTextures = [
        SKTexture(imageNamed: "ghost_00000"),
        SKTexture(imageNamed: "ghost_00001"),
        SKTexture(imageNamed: "ghost_00002"),
        SKTexture(imageNamed: "ghost_00003"),
        SKTexture(imageNamed: "ghost_00004"),
        SKTexture(imageNamed: "ghost_00005"),
        SKTexture(imageNamed: "ghost_00006"),
        SKTexture(imageNamed: "ghost_00007"),
        SKTexture(imageNamed: "ghost_00008"),
        SKTexture(imageNamed: "ghost_00009")
    ]
    
    let ghostAnimation = SKAction.animate(with: ghostTextures, timePerFrame: 0.05, resize: false, restore: true)
    let repeatGhost = SKAction.repeat(ghostAnimation, count: 1)
    ghostNode.run(repeatGhost, withKey: "ghost")
}
