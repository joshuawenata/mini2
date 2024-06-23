//
//  skillAttackViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 23/06/24.
//

import Foundation
import SpriteKit

func startSkillAnimation(projectileNode: SKSpriteNode?, imageSet: [String], timePerFrame: Double) {
    guard let projectileNode = projectileNode else { return }
    
    var projectileTextures: [SKTexture] = []
    for image in imageSet {
        projectileTextures.append(SKTexture(imageNamed: image))
    }
    
    let projectileAnimation = SKAction.animate(with: projectileTextures, timePerFrame: timePerFrame, resize: false, restore: true)
    let repeatProjectile = SKAction.repeat(projectileAnimation, count: 1)
    projectileNode.run(repeatProjectile, withKey: "skill")
}
