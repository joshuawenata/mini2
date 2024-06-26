//
//  backgroundViewModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 25/06/24.
//

import Foundation
import SpriteKit

extension BattleScene {
    func addBackground() -> SKSpriteNode {
        self.backgroundColor = .clear
        let background = SKSpriteNode(imageNamed: "battleIsland")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        return background
    }
}
