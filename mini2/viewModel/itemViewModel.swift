//
//  itemViewModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 25/06/24.
//

import Foundation
import SpriteKit

func addItem(_ position: CGPoint, addChild: (SKNode) -> Void, imageName: String, isPhysicsBody: Bool = false, category: UInt32 = 0, contact: UInt32 = 0, collision: UInt32 = 0) -> SKSpriteNode {
    
    guard let itemImage = UIImage(named: imageName) else {
        return SKSpriteNode()
    }
    
    let texture = SKTexture(image: itemImage)
    let item = SKSpriteNode(texture: texture)
    if(isPhysicsBody){
        item.physicsBody = SKPhysicsBody(texture: texture, size: item.size)
        item.physicsBody?.affectedByGravity = false
        item.physicsBody?.categoryBitMask = category
        item.physicsBody?.contactTestBitMask = contact
        item.physicsBody?.collisionBitMask = collision
    }
    item.position = position
    item.setScale(0.3)
    addChild(item)
    
    return item
}
