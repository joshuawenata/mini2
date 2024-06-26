//
//  nodeViewModel.swift
//  mini2
//
//  Created by Joshua Wenata Sunarto on 26/06/24.
//

import Foundation
import SpriteKit

func moveNode(node: SKSpriteNode? = nil, label: SKLabelNode? = nil, dx: CGFloat, dy: CGFloat) {
    if label != nil || node == nil {
        label?.position.y += dy
        label?.position.x += dx
    } else {
        node?.position.x += dx
        node?.position.y += dy
    }
}
