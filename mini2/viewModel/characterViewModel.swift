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
