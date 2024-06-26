//
//  hpBarViewModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 25/06/24.
//

import Foundation
import SpriteKit

extension BattleScene {
    func hpBarCharacterBattle() -> (SKSpriteNode, SKSpriteNode) {
        let hpBarOuterImage = UIImage(named: "hpbarouter")
        let hpBarInnerTexture = UIImage(named: "hpbarinner")

        let hpbartextureinner = SKTexture(image: hpBarInnerTexture!)
        let hpbarinner = SKSpriteNode(texture: hpbartextureinner)
        hpbarinner.position = CGPoint(x: 0, y: 54)
        
        let hpbartextureouter = SKTexture(image: hpBarOuterImage!)
        let hpbarouter = SKSpriteNode(texture: hpbartextureouter)
        hpbarouter.position = CGPoint(x: -5, y: 50)
        addChild(hpbarinner)
        addChild(hpbarouter)
        return (hpbarinner, hpbarouter)
    }
}
