//
//  buildingViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 11/06/24.
//

import Foundation

func addBuilding(at position: CGPoint, imageName: String) {
    let building = SKSpriteNode(imageNamed: imageName)
    building.position = position
    building.setScale(0.2)
    building.zPosition = -1
    addChild(building)
}
