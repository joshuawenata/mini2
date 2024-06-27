//
//  CharacterViewModel.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 21/06/24.
//

import Foundation
import SpriteKit

extension BattleScene {
    func startGetHitAnimation(characterNode: SKSpriteNode?) {
        guard let characterNode = characterNode else { return }
        
        var getHitTextures: [SKTexture] = []
        
        for i in 0...7 {
            let getHitTexture = String(format: "red_%05d", i)
            getHitTextures.append(SKTexture(imageNamed: getHitTexture))
        }
        
        let getHitAnimation = SKAction.animate(with: getHitTextures, timePerFrame: 0.05, resize: false, restore: true)
        let repeatGetHit = SKAction.repeat(getHitAnimation, count: 1)
        characterNode.run(repeatGetHit, withKey: "getHit")
    }
    
    func startGhostAnimation(ghostNode: SKSpriteNode?) {
        guard let ghostNode = ghostNode else { return }
        
        var ghostTextures: [SKTexture] = []
        
        for i in 0...29 {
            let textureName = String(format: "death_%05d", i)
            ghostTextures.append(SKTexture(imageNamed: textureName))
        }
        
        let ghostAnimation = SKAction.animate(with: ghostTextures, timePerFrame: 0.05, resize: false, restore: true)
        let repeatGhost = SKAction.repeat(ghostAnimation, count: 1)
        ghostNode.run(repeatGhost, withKey: "ghost")
    }
    
}

func createCharacter(_ position: CGPoint, addChild: (SKNode) -> Void, category: UInt32, contact: UInt32, collision: UInt32, isBattle: Bool) -> SKSpriteNode {
    let characterImage = UIImage(named: isBattle ? "charaIdleBattle" : "charaIdle")
    
    let texture = SKTexture(image: characterImage!)
    let character = SKSpriteNode(texture: texture)
    character.physicsBody = SKPhysicsBody(texture: texture, size: character.size)
    character.physicsBody?.affectedByGravity = false
    character.position = position
    character.setScale(0.3)
    character.physicsBody?.categoryBitMask = category
    character.physicsBody?.contactTestBitMask = contact
    character.physicsBody?.collisionBitMask = collision
    
    addChild(character)
    return character
}

func playerNameLabel(addChild: (SKNode) -> Void, name: String, position: CGPoint) -> SKLabelNode {
    let playerName = SKLabelNode(text: name)
    playerName.position = position
    playerName.fontColor = .white
    playerName.fontSize = 18
    playerName.fontName = "AveriaSerifLibre-Regular"
    addChild(playerName)
    return playerName
}

func addCharacter(_ position: CGPoint, addChild: (SKNode) -> Void, category: UInt32, contact: UInt32, collision: UInt32, name: String, isBattle: Bool) -> (SKSpriteNode, SKSpriteNode, SKSpriteNode, SKLabelNode, SKSpriteNode, SKSpriteNode, SKSpriteNode, SKSpriteNode) {
    
    let character = createCharacter(position, addChild: addChild, category: category, contact: contact, collision: collision, isBattle: isBattle)
    let (hpbarinner, hpbarouter) = hpBarCharacter(addChild: addChild, position: position)
    let playerName = playerNameLabel(addChild: addChild, name: name, position: CGPoint(x: character.position.x, y: character.position.y + 70))
    let swordNode = addItem(CGPoint(x: position.x-40, y: position.y), addChild: addChild, imageName: "defaultSword")
    let meleeAreaNode = addItem(CGPoint(x: position.x-60, y: position.y), addChild: addChild, imageName: "meleeArea",isPhysicsBody: true, category: PhysicsCategory.meleeArea, contact: PhysicsCategory.enemy, collision: PhysicsCategory.none)
    let rangeAreaNode = addItem(CGPoint(x: position.x-60, y: position.y), addChild: addChild, imageName: "rangeArea",isPhysicsBody: false, category: PhysicsCategory.rangeArea, contact: PhysicsCategory.enemy, collision: PhysicsCategory.none)
    let slashNode = addItem(CGPoint(x: position.x-60, y: position.y), addChild: addChild, imageName: "slash_00000")
    meleeAreaNode.isHidden = true
    meleeAreaNode.zPosition = -1
    rangeAreaNode.isHidden = true
    rangeAreaNode.zPosition = -1
    slashNode.isHidden = true
    swordNode.zRotation = -20
    slashNode.setScale(0.5)
    if(!isBattle) {
        swordNode.isHidden = true
    }
    
    return (character, hpbarinner, hpbarouter, playerName, swordNode, meleeAreaNode, rangeAreaNode, slashNode)
}
