//
//  hpBarViewModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 25/06/24.
//

import Foundation
import SpriteKit

func hpBarCharacter(addChild: (SKNode) -> Void, position: CGPoint) -> (SKSpriteNode, SKSpriteNode) {
    let hpBarOuterImage = UIImage(named: "hpbarouter")
    let hpBarInnerTexture = UIImage(named: "hpbarinner")
    
    let hpbartextureinner = SKTexture(image: hpBarInnerTexture!)
    let hpbarinner = SKSpriteNode(texture: hpbartextureinner)
    hpbarinner.position = CGPoint(x: position.x, y: position.y + 54)
    
    let hpbartextureouter = SKTexture(image: hpBarOuterImage!)
    let hpbarouter = SKSpriteNode(texture: hpbartextureouter)
    hpbarouter.position = CGPoint(x: position.x-5, y: position.y+50)
    addChild(hpbarinner)
    addChild(hpbarouter)
    return (hpbarinner, hpbarouter)
}
