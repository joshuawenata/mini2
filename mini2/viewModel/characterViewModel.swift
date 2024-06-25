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

func startGetHitAnimation(characterNode: SKSpriteNode?) {
    guard let characterNode = characterNode else { return }
    
    var getHitTextures: [SKTexture] = []
    
    for i in 0...7 {
        let getHitTexture = String(format: "red_%05d", i)
        getHitTextures.append(SKTexture(imageNamed: getHitTexture))
    }
    
    let getHitAnimation = SKAction.animate(with: getHitTextures, timePerFrame: 0.05, resize: false, restore: true)
    let repeatGetHit = SKAction.repeat(getHitAnimation, count: 1)
    characterNode.run(repeatGetHit, withKey: "getHit")
}

func startGhostAnimation(ghostNode: SKSpriteNode?) {
    guard let ghostNode = ghostNode else { return }
    
    var ghostTextures: [SKTexture] = []

    for i in 0...29 {
        let textureName = String(format: "death_%05d", i)
        ghostTextures.append(SKTexture(imageNamed: textureName))
    }
    
    let ghostAnimation = SKAction.animate(with: ghostTextures, timePerFrame: 0.05, resize: false, restore: true)
    let repeatGhost = SKAction.repeat(ghostAnimation, count: 1)
    ghostNode.run(repeatGhost, withKey: "ghost")
}

