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
