//
//  projectileModelView.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 25/06/24.
//

import Foundation
import SpriteKit

extension BattleScene {
    func addProjectile() -> SKSpriteNode {
        let projectileImage = UIImage(named: "fire_1")
        
        let texture = SKTexture(image: projectileImage!)
        let projectile = SKSpriteNode(texture: texture)
        projectile.setScale(0.2)
        
        return projectile
    }
}
