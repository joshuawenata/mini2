//
//  mapViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 26/06/24.
//

import Foundation
import SpriteKit

func addBackgroundMainIsland(size: CGSize, addChild: (SKNode) -> Void) {
    let background = SKSpriteNode(imageNamed: "mainIsland")
    background.position = CGPoint(x: size.width / 2 - 1500, y: size.height / 2)
    background.zPosition = -1
    addChild(background)
}

func addBackgroundBattleIsland(size: CGSize, addChild: (SKNode) -> Void) {
    let background = SKSpriteNode(imageNamed: "battleIsland")
    background.position = CGPoint(x: size.width / 2, y: size.height / 2)
    background.zPosition = -1
    addChild(background)
}
