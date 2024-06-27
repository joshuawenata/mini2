//
//  sendDataViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 27/06/24.
//

import Foundation

extension BattleScene {
    
    func sendProjectileToAnotherPlayer() {
        startSkillAnimation(projectileNode: anotherProjectileNode, imageSet: ["fire_1", "fire_2", "fire_3", "fire_4", "fire_5"], timePerFrame: 0.1)
        anotherProjectileNode = projectileMove(angle: gameCenter.dataModel!.angleProjectile, projectile: anotherProjectileNode)
        addChild(anotherProjectileNode)
    }
    
}
