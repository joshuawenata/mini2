//
//  botViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 26/06/24.
//

import Foundation
import UIKit
import SpriteKit

extension BattleScene {
    func addDummyRobot(_ position: CGPoint, category: UInt32, contact: UInt32) {
        guard let characterImage = UIImage(named: "charaIdleBattle") else {
            return
        }
        
        let texture = SKTexture(image: characterImage)
        let character = SKSpriteNode(texture: texture)
        character.physicsBody = SKPhysicsBody(texture: texture, size: character.size)
        character.physicsBody?.affectedByGravity = false
        character.physicsBody?.allowsRotation = false
        character.position = position
        character.setScale(0.3)
        character.physicsBody?.categoryBitMask = category
        character.physicsBody?.contactTestBitMask = contact
        character.physicsBody?.isDynamic = false
        
        addChild(character)
        
        self.dummyRobot = character
    }
}
