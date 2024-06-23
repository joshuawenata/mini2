//
//  buildingViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 11/06/24.
//

import Foundation
import SpriteKit

func addBuilding(at position: CGPoint, imageName: String) -> SKSpriteNode {
    let building = SKSpriteNode(imageNamed: imageName)
    building.physicsBody = SKPhysicsBody(rectangleOf: building.size)
    building.position = position
    building.name = imageName
    building.setScale(0.2)
    building.zPosition = -1
    building.physicsBody?.affectedByGravity = false
    building.physicsBody?.allowsRotation = false
    building.physicsBody?.categoryBitMask = CollisionCategory.building.rawValue
    building.physicsBody?.collisionBitMask = CollisionCategory.building.rawValue
    building.physicsBody?.contactTestBitMask = CollisionCategory.building.rawValue
    building.physicsBody?.isDynamic = false
    
    return building
}

func startBlacksmithAnimation(blacksmithNode: SKSpriteNode?) {
    var blacksmithTexture: [SKTexture] = []
            
    for i in 0...29 {
        let textureName = String(format: "blacksmith_%05d", i)
        let texture = SKTexture(imageNamed: textureName)
        blacksmithTexture.append(texture)
    }
    
    let blacksmithAnimation = SKAction.animate(with: blacksmithTexture, timePerFrame: 0.05, resize: false, restore: true)
    let repeatBlacksmith = SKAction.repeatForever(blacksmithAnimation)
    blacksmithNode?.run(repeatBlacksmith, withKey: "blacksmith")
}

func startHorseAnimation(horseNode: SKSpriteNode?) {
    var horseTexture: [SKTexture] = []
    
    for i in 0...29 {
        let textureName = String(format: "horse_%05d", i)
        let texture = SKTexture(imageNamed: textureName)
        horseTexture.append(texture)
    }
    
    let horseAnimation = SKAction.animate(with: horseTexture, timePerFrame: 0.05, resize: false, restore: true)
    let repeatHorse = SKAction.repeatForever(horseAnimation)
    horseNode?.run(repeatHorse, withKey: "horse")
}

func startRiverAnimation(riverNode: SKSpriteNode?) {
    var riverTexture: [SKTexture] = []
    
    for i in 2...4 {
        let textureName = String(format: "river%d", i)
        let texture = SKTexture(imageNamed: textureName)
        riverTexture.append(texture)
    }
    
    let riverAnimation = SKAction.animate(with: riverTexture, timePerFrame: 0.1, resize: false, restore: true)
    let repeatRiver = SKAction.repeatForever(riverAnimation)
    riverNode?.run(repeatRiver, withKey: "river")
}
